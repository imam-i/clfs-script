#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%ONFIG
LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
  ../${PACK}/configure \
	--prefix=/cross-tools \
	--disable-static \
	--with-gmp-prefix=/cross-tools \
	--with-isl-prefix=/cross-tools

sed -e '/cmake/d' \
    -i Makefile

%BUILD%
make

%INSTALL%
make install

#######################################
