#######################################
#local _name=$(echo ${LINUX_LFS} | cut -d\; -f2)
#local _version=$(echo ${LINUX_LFS} | cut -d\; -f3)

#pushd ${BUILD_DIR}
#unarch || return ${?}
pushd ${CLFS_SRC}/linux || return ${?}

make mrproper || return ${?}
make ARCH=${CLFS_ARCH} headers_check || return ${?}
make ARCH=${CLFS_ARCH} INSTALL_HDR_PATH=${CLFS}/usr headers_install || return ${?}
popd

#######################################
