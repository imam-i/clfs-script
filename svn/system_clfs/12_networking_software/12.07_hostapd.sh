#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

cd hostapd && cat > .config << EOF
# Support for nl80211 driver
CONFIG_DRIVER_NL80211=y
# Use v2.0 of the netlink appi
CFLAGS += -DCONFIG_LIBNL20
LDFLAGS += -lnl-genl

CONFIG_RSN_PREAUTH=y

# PeerKey handshake for Station to Station Link (IEEE 802.11e DLS)
CONFIG_PEERKEY=y
# Support draft ieee 802.11n
CONFIG_IEEE80211N=y

# Remove debugging code that is printing out debug messages to stdout.
# This can be used to reduce the size of the hostapd considerably if debugging
# code is not needed.
CONFIG_NO_STDOUT_DEBUG=y
EOF

make CFLAGS="-g -Os -Wall" || return ${?}
cp hostapd hostapd_cli ${CLFS}/usr/sbin || return ${?}

cd ${CLFS_SRC}/bootscripts-embedded &&
make install-hostapd DESTDIR=${CLFS} || return ${?}

cat > ${CLFS}/etc/hostapd.conf << EOF
# Sample hostapd.conf
# See hostapd/hostapd.conf in your hostap source tree for a more detailed version
interface=wlan0
bridge=br0
ctrl_interface=/var/run/hostapd
ssid=dummy
#country_code=US
country_code=EU
hw_mode=g
channel=4

# wpa=1 only allow WPA1
# wpa=2 allow WPA2 only
# wpa=3 allow WPA1 + WPA2
wpa=2
wpa_passphrase=foobar123
# b43 drivers seem to have issues at the moment with CCMP encryption
# dropping packets among other things so use TKIP (AES) only for now
wpa_pairwise=TKIP
rsn_pairwise=TKIP
EOF

popd

#######################################
