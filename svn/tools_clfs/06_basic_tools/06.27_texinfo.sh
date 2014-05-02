#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
PERL=/usr/bin/perl \
  CC="${CC} ${BUILD64}" \
    ../${PACK}/configure \
	--prefix=/tools \
	--build=${CLFS_HOST} \
	--host=${CLFS_TARGET}

%BUILD%
make

%INSTALL%
make install

#######################################
