#!/bin/bash
################################################################################
# Функция "tools_clfs"
# Version: 0.1

tools_clfs ()
{
local CLFS_FLAG='tools-clfs'

local _LOG

color-echo "tools_clfs" ${YELLOW}

date > "${CLFS_LOG}/tools_clfs.log"

# Основные каталоги и ссылки
install -dv ${CLFS}/cross-tools{,/bin} ${CLFS_SRC}

# Очистка сборочной папки
rm -Rf ${BUILD_DIR}
install -dv ${BUILD_DIR}

if [ -z "$(fgrep clfs /etc/group)" ]; then
	groupadd clfs
fi

if [ -z "$(fgrep clfs /etc/passwd)" ]; then
	useradd -s /bin/bash -g clfs -m -k /dev/null clfs
else
	usermod -s /bin/bash -g clfs -m -d /home/clfs clfs
fi

yes 'clfs' | passwd clfs

cat > /home/clfs/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > /home/clfs/.bashrc << EOF
set +h
umask 022
CLFS=${CLFS}
LC_ALL=POSIX
PATH=${CLFS}/cross-tools/bin:/bin:/usr/bin
export CLFS LC_ALL PATH

# Clear compiler flags
unset CFLAGS
unset CXXFLAGS
 
# Set ABI
export CLFS_ABI=aapcs-linux

# Set host and target
export CLFS_HOST=$(echo ${MACHTYPE} | sed "s/-[^-]*/-cross/")
export CLFS_TARGET=arm-unknown-linux-uclibcgnueabi

# Set architecture and endianess
export CLFS_ARCH=arm
export CLFS_ENDIAN=little

# Set specific ARM architecture
export CLFS_ARM_ARCH=armv6zk
export CLFS_ARM_MODE=arm

# Set hw float of type vfp
export CLFS_FLOAT=hard
export CLFS_FPU=vfp
EOF

#if [ ${J2_LFS_FLAG} -gt 0 ]; then
#	echo "export MAKEFLAGS=\"-j ${J2_LFS_FLAG}\"" >> /home/lfs/.bashrc
#fi

# ---------------------------------
cat >> /home/clfs/.bashrc << EOF
CLFS_PWD="${CLFS_PWD}"
export CLFS_PWD

${CLFS_PWD}/_su/_ctools.sh ${TOOLS_CLFS_FLAG} ${SYSTEM_CLFS_FLAG} ${BLFS_FLAG} ${CHROOT_FLAG}
exit \${?}
EOF
# ---------------------------------
color-echo "Смена прав на каталоги: clfs /home/clfs ${CLFS} ${CLFS_SRC} ${CLFS_LOG} ${CLFS_OUT} ${CLFS_PKG} ${BUILD_DIR} ${CLFS_PWD}/${PREFIX}/ctools" ${CYAN}
chown -R clfs /home/clfs "${CLFS}" "${CLFS_SRC}" "${CLFS_LOG}" "${CLFS_OUT}" "${CLFS_PKG}" "${BUILD_DIR}" "${CLFS_PWD}/${PREFIX}/ctools"

sed -e "/^PKGDEST=/ c\PKGDEST=${CLFS_PKG}" \
    -e "/^SRCDEST=/ c\SRCDEST=${CLFS_SRC}" \
    -i ${CLFS_CONF}/makepkg.conf

pacman_no_root

su - clfs

date >> "${CLFS_LOG}/tools_clfs.log"
}

################################################################################
