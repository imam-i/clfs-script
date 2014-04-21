#######################################
#local _name=$(echo ${LINUX_LFS} | cut -d\; -f2)
#local _version=$(echo ${LINUX_LFS} | cut -d\; -f3)

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

make mrproper || return ${?}
make ARCH=${CLFS_ARCH} headers_check || return ${?}
make ARCH=${CLFS_ARCH} INSTALL_HDR_PATH=/tools headers_install || return ${?}
#find ${CLFS}/usr/include -name .install -or -name ..install.cmd | xargs rm -fv
popd

#######################################
