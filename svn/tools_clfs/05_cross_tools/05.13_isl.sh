#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
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
