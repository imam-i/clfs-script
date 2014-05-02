#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
../${PACK}/configure \
	--prefix=/cross-tools \
	--enable-cxx \
	--disable-static

%BUILD%
make

%INSTALL%
make install

#######################################
