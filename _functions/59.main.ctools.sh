#!/bin/bash
################################################################################
# Функция "tools_clfs"
# Version: 0.1

f_tools_clfs ()
{
local CLFS_FLAG='tools-clfs'

case ${TOOLS_CLFS_FLAG} in
#	3) rm -fv ${CLFS_OUT}/??_${CLFS_ARCH}_clfs.tar.bz2 ;;
	2) rm -fv ${CLFS_OUT}/06_${CLFS_ARCH}_clfs.tar.bz2 ;;
	1) rm -fv ${CLFS_OUT}/05_${CLFS_ARCH}_clfs.tar.bz2 ;;
	0)
		if [ "${SYSTEM_CLFS_FLAG}" -eq 0 ] && \
		   [ "${BLFS_FLAG}" -eq 0 ]; then
			return 0
		fi
	;;
	*) echo 'Не верный параметер константы "TOOLS_LFS_FLAG"' ;;
esac

color-echo "f_tools_clfs" ${YELLOW}

#local CLFS_MF_LOG="${CLFS_LOG}/tools_clfs.log"
#date > "${CLFS_MF_LOG}"

# 4.2. Creating the ${CLFS}/tools Directory
rm -rf ${CLFS_TOOLS} /tools
install -dv ${CLFS_TOOLS}
ln -sv ${CLFS_TOOLS} /

# 4.3. Creating the ${CLFS}/cross-tools Directory
rm -rf ${CLFS_CROSS_TOOLS} /cross-tools
install -dv ${CLFS_CROSS_TOOLS}
ln -sv ${CLFS_CROSS_TOOLS} /

# 4.4. Adding the CLFS User
if [ -z "$(fgrep clfs /etc/group)" ]; then
	groupadd clfs
fi

if [ -z "$(fgrep clfs /etc/passwd)" ]; then
	useradd -s /bin/bash -g clfs -m -d /home/clfs clfs
else
	usermod -s /bin/bash -g clfs -m -d /home/clfs clfs
fi
install -dv /home/clfs
yes 'clfs' | passwd clfs
chown -v clfs ${CLFS_TOOLS}
chown -v clfs ${CLFS_CROSS_TOOLS}
chown -v clfs ${CLFS_SRC}

#########################################
# Основные каталоги и ссылки
#install -dv ${CLFS_CROSS_TOOLS}{,/bin} ${CLFS_SRC}

# Очистка сборочной папки
rm -Rf ${BUILD_DIR}
install -dv ${BUILD_DIR}
#########################################

# 4.5. Setting Up the Environment
cat > /home/clfs/.bash_profile << "EOF"
exec env -i HOME=${HOME} TERM=${TERM} PS1='\u:\w\$ ' /bin/bash
EOF

cat > /home/clfs/.bashrc << EOF
set +h
umask 022
CLFS=${CLFS}
LC_ALL=POSIX
PATH=/cross-tools/bin:/bin:/usr/bin
export CLFS LC_ALL PATH

# назначаем переменные CLFS_PWD CLFS_CROSS_TOOLS CLFS_TOOLS CLFS_ARCH
export CLFS_PWD=${CLFS_PWD}
export CLFS_CROSS_TOOLS=${CLFS_CROSS_TOOLS}
export CLFS_TOOLS=${CLFS_TOOLS}
export CLFS_ARCH=${CLFS_ARCH}

# 5.2. Build CFLAGS
unset CFLAGS
unset CXXFLAGS

# 5.3. Build Flags
case "\${CLFS_ARCH}" in
	'x86_64') export BUILD64="-m64" ;;
esac

# 5.4. Build Variables
export CLFS_HOST=`echo ${MACHTYPE} | sed -e 's/-[^-]*/-cross/'`
export CLFS_TARGET="${CLFS_ARCH}-unknown-linux-gnu"
EOF

install -d ${CLFS}/etc
# 4.5. Creating the passwd, group, and log Files
cat > ${CLFS}/etc/passwd << "EOF"
root::0:0:root:/root:/bin/bash
EOF

cat > ${CLFS}/etc/group << "EOF"
root:x:0:
bin:x:1:
sys:x:2:
kmem:x:3:
tty:x:4:
tape:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
EOF

install -d ${CLFS}/var/{run,log}
touch ${CLFS}/var/run/utmp ${CLFS}/var/log/{btmp,lastlog,wtmp}
chmod -v 664 ${CLFS}/var/run/utmp ${CLFS}/var/log/lastlog
chmod -v 600 ${CLFS}/var/log/btmp
###########################################################

# ---------------------------------
cat >> /home/clfs/.bashrc << EOF

${CLFS_PWD}/_su/_ctools.sh ${TOOLS_CLFS_FLAG} ${SYSTEM_CLFS_FLAG} ${BLFS_FLAG} ${SU_FLAG}
exit \${?}
EOF
# ---------------------------------
color-echo "Смена прав на каталоги: /home/clfs ${CLFS} ${CLFS_LOG} ${CLFS_OUT} ${CLFS_PKG} ${BUILD_DIR} ${CLFS_PWD}/${PREFIX}/tools_clfs" ${CYAN}
chown -R clfs /home/clfs "${CLFS_LOG}" "${CLFS_OUT}" "${CLFS_PKG}" "${BUILD_DIR}" "${CLFS_PWD}/${PREFIX}/tools_clfs"

su - clfs

#date >> "${CLFS_MF_LOG}"
}

################################################################################
