#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
pushd ../${PACK}
    patch -Np1 -i ${CLFS_SRC}/${PACK}-bash_fix-1.patch
popd

CC="${CC} ${BUILD64}" \
  CXX="${CXX} ${BUILD64}" \
    ../${PACK}/configure \
	--prefix=/tools \
	--with-shared \
	--build=${CLFS_HOST} \
	--host=${CLFS_TARGET} \
	--without-debug \
	--without-ada \
	--enable-overwrite \
	--with-build-cc=gcc

%BUILD%
make

%INSTALL%
make install

#######################################
