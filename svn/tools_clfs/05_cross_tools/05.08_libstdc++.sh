#######################################

#pushd ${BUILD_DIR}
#unarch 'mpfr' 'gmp' 'mpc' || return ${?}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
../${PACK}/libstdc++-v3/configure \
	--target=${CLFS_TARGET} \
	--prefix=/tools \
	--disable-multilib \
	--disable-shared \
	--disable-nls \
	--disable-libstdcxx-threads \
	--disable-libstdcxx-pch \
	--with-gxx-include-dir=/tools/${CLFS_TARGET}/include/c++/${version}

%BUILD%
make

%INSTALL%
make install

#######################################
