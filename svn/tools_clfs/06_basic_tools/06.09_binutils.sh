#######################################

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

mkdir -v ../binutils-build && cd ../binutils-build

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
			--disable-multilib || return ${?}
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
			--disable-multilib || return ${?}
	;;
esac

make configure-host || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
