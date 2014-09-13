#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
make -C ../${PACK} mrproper

%BUILD%
make -C ../${PACK} INSTALL_HDR_PATH=dest headers_install

%INSTALL%
cp -rv ../${PACK}/dest/include/* /tools/include

#######################################
