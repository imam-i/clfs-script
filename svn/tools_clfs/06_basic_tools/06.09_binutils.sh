#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

#mkdir -v ../binutils-build && cd ../binutils-build

%CONFIG%
case "${CLFS_ARCH}" in
	'x86_64')
	CC="${CC} ${BUILD64}" \
	    ../${PACK}/configure \
		--prefix=/tools \
		--build=${CLFS_HOST} \
		--host=${CLFS_TARGET} \
		--target=${CLFS_TARGET} \
		--with-lib-path=/tools/lib \
		--disable-nls \
		--enable-shared \
		--enable-64-bit-bfd \
		--disable-multilib
	;;
	*)
	    ../${PACK}/configure \
		--prefix=/tools \
		--build=${CLFS_HOST} \
		--host=${CLFS_TARGET} \
		--target=${CLFS_TARGET} \
		--with-lib-path=/tools/lib \
		--disable-nls \
		--enable-shared \
		--disable-multilib
	;;
esac

%BUILD%
#make configure-host
make

%INSTALL%
make install

#######################################
