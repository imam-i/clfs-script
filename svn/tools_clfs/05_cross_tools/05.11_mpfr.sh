#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
pushd ../${PACK}
    patch -Np1 -i ${CLFS_SRC}/${PACK}-fixes-2.patch
popd

LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
  ../${PACK}/configure \
	--prefix=/cross-tools \
	--disable-static \
	--with-gmp=/cross-tools

%BUILD%
make

%INSTALL%
make install

#######################################
