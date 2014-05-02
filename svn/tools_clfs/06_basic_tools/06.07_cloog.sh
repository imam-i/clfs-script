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
	--enable-shared \
	--with-gmp-prefix=/tools \
	--with-isl-prefix=/tools

sed -e '/cmake/d' \
    -i Makefile

%BUILD%
make

%INSTALL%
make install

#######################################
