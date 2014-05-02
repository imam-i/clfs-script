#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
CC="${CC} ${BUILD64}" \
    ../${PACK}/configure \
	--prefix=/tools \
	--build=${CLFS_HOST} \
	--host=${CLFS_TARGET} \
	--with-gmp=/tools

%BUILD%
make

%INSTALL%
make install

#######################################
