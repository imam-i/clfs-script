#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
cd ./${PACK}

mkdir -v ../binutils-build && cd ../binutils-build

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
			--disable-multilib || return ${?}
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
			--disable-multilib || return ${?}
	;;
esac

make configure-host || return ${?}
make || return ${?}
make install || return ${?}
cp -v ../${PACK}/include/libiberty.h /tools/include || return ${?}
popd

#######################################
