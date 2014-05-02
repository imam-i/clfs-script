#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
CC="${CC} ${BUILD64}" \
    ../${PACK}/configure \
	--prefix=/tools

%BUILD%
make

%INSTALL%
make install

#######################################
