#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
HOST_CC=gcc \
  CC="${CC} ${BUILD64}" \
  CXX="${CXX} ${BUILD64}" \
    ../${PACK}/configure \
	--prefix=/tools \
	--build=${CLFS_HOST} \
	--host=${CLFS_TARGET} \
	--enable-cxx

%BUILD%
make

%INSTALL%
make install

#######################################
