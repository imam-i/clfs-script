#!/bin/bash
################################################################################
# Функция "tools"
# Version: 0.1

main_tools ()
{
local CLFS_FLAG="${FUNCNAME}"

case ${TOOLS_FLAG} in
#	3) rm -fv ${CLFS_OUT}/??_${CLFS_ARCH}_clfs.tar.bz2 ;;
	2) rm -fv ${CLFS_OUT}/pm_${CLFS_ARCH}_clfs.tar.bz2 ;;
	1) rm -fv ${CLFS_OUT}/??_${CLFS_ARCH}_clfs.tar.bz2 ;;
	0)
		if [ "${SYSTEM_FLAG}" -eq 0 ] && \
		   [ "${BLFS_FLAG}" -eq 0 ]; then
			return 0
		fi
	;;
	*) echo 'Не верный параметер константы "TOOLS_FLAG"' ;;
esac

color-echo "${FUNCNAME}" ${YELLOW}

#local CLFS_MF_LOG="${CLFS_LOG}/tools.log"
#date > "${CLFS_MF_LOG}"

# 4.2. Creating the ${CLFS}/tools Directory
rm -rf ${CLFS_TOOLS} /tools
install -dv ${CLFS_TOOLS}
ln -sv ${CLFS_TOOLS} /

## 4.3. Creating the ${CLFS}/cross-tools Directory
#rm -rf ${CLFS_CROSS_TOOLS} /cross-tools
#install -dv ${CLFS_CROSS_TOOLS}
#ln -sv ${CLFS_CROSS_TOOLS} /

# 4.3. Adding the CLFS User
if [ -z "$(fgrep clfs /etc/group)" ]; then
	groupadd clfs
fi

if [ -z "$(fgrep clfs /etc/passwd)" ]; then
	useradd -s /bin/bash -g clfs -m -k /dev/null -d /home/clfs clfs
else
	usermod -s /bin/bash -g clfs -m -d /home/clfs clfs
fi
install -dv /home/clfs
yes 'clfs' | passwd clfs || [ "${?}" -eq 141 ] && true || false
chown -v clfs ${CLFS_TOOLS}
#chown -v clfs ${CLFS_CROSS_TOOLS}
chown -v clfs ${CLFS_SRC}

#########################################
# Основные каталоги и ссылки
#install -dv ${CLFS_CROSS_TOOLS}{,/bin} ${CLFS_SRC}

# Очистка сборочной папки
rm -Rf ${BUILD_DIR}
install -dv ${BUILD_DIR}
#########################################

# 4.4. Setting Up the Environment
cat > /home/clfs/.bash_profile << "EOF"
exec env -i HOME=${HOME} TERM=${TERM} PS1='\u:\w\$ ' /bin/bash
EOF

cat > /home/clfs/.bashrc << EOF
set +h
umask 022
CLFS=${CLFS}
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export CLFS LC_ALL LFS_TGT PATH

# назначаем переменные CLFS_PWD CLFS_CROSS_TOOLS CLFS_TOOLS CLFS_ARCH
export CLFS_PWD=${CLFS_PWD}
export CLFS_CROSS_TOOLS=${CLFS_CROSS_TOOLS}
export CLFS_TOOLS=${CLFS_TOOLS}
export CLFS_ARCH=${CLFS_ARCH}

# Флаги
export PACKAGES_FLAG=${PACKAGES_FLAG}
export TOOLS_FLAG=${TOOLS_FLAG}
export SYSTEM_FLAG=${SYSTEM_FLAG}
export BLFS_FLAG=${BLFS_FLAG}
export SU_FLAG=${SU_FLAG}

## 5.2. Build CFLAGS
#unset CFLAGS
#unset CXXFLAGS

## 5.3. Build Flags
#case "\${CLFS_ARCH}" in
#	'x86_64') export BUILD64="-m64" ;;
#esac

# 5.4. Build Variables
export CLFS_HOST=`echo ${MACHTYPE} | sed -e 's/-[^-]*/-cross/'`
export CLFS_TARGET="\${CLFS_ARCH}-unknown-linux-gnu"
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

#install -d ${CLFS}/var/{run,log}
#touch ${CLFS}/var/run/utmp ${CLFS}/var/log/{btmp,lastlog,wtmp}
#chmod -v 664 ${CLFS}/var/run/utmp ${CLFS}/var/log/lastlog
#chmod -v 600 ${CLFS}/var/log/btmp
###########################################################

# ---------------------------------
cat >> /home/clfs/.bashrc << EOF

${CLFS_PWD}/_su/_ctools.sh
exit \${?}
EOF
# ---------------------------------
color-echo "Смена прав на каталоги: /home/clfs ${CLFS} ${CLFS_LOG} ${CLFS_OUT} ${CLFS_PKG} ${BUILD_DIR} ${CLFS_PWD}/${PREFIX}/tools" ${CYAN}
chown -R \
	clfs \
	/home/clfs \
	"${CLFS_LOG}" \
	"${CLFS_OUT}" \
	"${CLFS_PKG}" \
	"${BUILD_DIR}" \
	"${CLFS_PWD}/${PREFIX}/tools"

su - clfs

#date >> "${CLFS_MF_LOG}"
}

################################################################################
