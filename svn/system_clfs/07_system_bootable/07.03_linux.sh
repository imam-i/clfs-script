#######################################
#local _name=$(echo ${LINUX_LFS} | cut -d\; -f2)
#local _version=$(echo ${LINUX_LFS} | cut -d\; -f3)

#pushd ${BUILD_DIR}
#unarch || return ${?}
pushd ${CLFS_SRC}/linux || return ${?}

# Linux
make mrproper || return ${?}
make ARCH=${CLFS_ARCH} bcmrpi_cutdown_defconfig || return ${?}
make ARCH=${CLFS_ARCH} CROSS_COMPILE=${CLFS_CROSS_COMPILE} oldconfig || return ${?}
make ARCH=${CLFS_ARCH} CROSS_COMPILE=${CLFS_CROSS_COMPILE} || return ${?}
make ARCH=${CLFS_ARCH} CROSS_COMPILE=${CLFS_CROSS_COMPILE} \
     modules_install INSTALL_MOD_PATH=${CLFS}/boot || return ${?}

# tools
cd ${CLFS_SRC}/tools/mkimage || return ${?}
./imagetool-uncompressed.py ${CLFS_SRC}/linux/arch/arm/boot/Image || return ${?}
cp -v kernel.img ${CLFS}/boot/ || return ${?}

# firmware
cp -v ${CLFS_SRC}/firmware/boot/{bootcode.bin,fixup.dat,fixup_cd.dat,start.elf,start_cd.elf} \
${CLFS}/boot/ || return ${?}

popd

#######################################
