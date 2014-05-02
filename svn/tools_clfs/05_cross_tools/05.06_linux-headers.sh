#######################################
#local _name=$(echo ${LINUX_LFS} | cut -d\; -f2)
#local _version=$(echo ${LINUX_LFS} | cut -d\; -f3)

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
make -C ../${PACK} mrproper

%BUILD%
make -C ../${PACK} ARCH=${CLFS_ARCH} headers_check

%INSTALL%
make -C ../${PACK} ARCH=${CLFS_ARCH} INSTALL_HDR_PATH=/tools headers_install

#######################################
