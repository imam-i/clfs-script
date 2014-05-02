#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
pushd ../${PACK}
    patch -Np1 -i ${CLFS_SRC}/${PACK}-fixes-2.patch
popd

CC="${CC} ${BUILD64}" \
    ../${PACK}/configure \
	--prefix=/tools \
	--build=${CLFS_HOST} \
	--host=${CLFS_TARGET} \
	--enable-shared

%BUILD%
make

%INSTALL%
make install

#######################################
