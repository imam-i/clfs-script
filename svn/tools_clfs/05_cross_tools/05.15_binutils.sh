#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

#mkdir -v ../binutils-build && cd ../binutils-build

%CONFIG%
case "${CLFS_ARCH}" in
	'x86_64')
		AR=ar AS=as \
		../${PACK}/configure \
			--prefix=/cross-tools \
			--host=${CLFS_HOST} \
			--target=${CLFS_TARGET} \
			--with-sysroot=${CLFS} \
			--with-lib-path=/tools/lib \
			--disable-nls \
			--disable-static \
			--enable-64-bit-bfd \
			--disable-multilib
	;;
	*)
		AR=ar AS=as \
		../${PACK}/configure \
			--prefix=/cross-tools \
			--host=${CLFS_HOST} \
			--target=${CLFS_TARGET} \
			--with-sysroot=${CLFS} \
			--with-lib-path=/tools/lib \
			--disable-nls \
			--disable-static \
			--disable-multilib
	;;
esac

%BUILD%
make configure-host
make

%INSTALL%
make install
cp -v ../${PACK}/include/libiberty.h /tools/include

#######################################
