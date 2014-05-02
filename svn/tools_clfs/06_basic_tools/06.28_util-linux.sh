#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
CC="${CC} ${BUILD64}" \
  PKG_CONFIG= \
    ../${PACK}/configure \
	--prefix=/tools \
	--build=${CLFS_HOST} \
	--host=${CLFS_TARGET} \
	--disable-makeinstall-chown \
	--disable-makeinstall-setuid

%BUILD%
make

%INSTALL%
make install

#######################################
