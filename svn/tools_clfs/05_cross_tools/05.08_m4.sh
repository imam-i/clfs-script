#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
../${PACK}/configure \
	--prefix=/cross-tools

%BUILD%
make

%INSTALL%
make install

#######################################
