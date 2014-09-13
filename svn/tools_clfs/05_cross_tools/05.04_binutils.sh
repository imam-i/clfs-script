#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

#mkdir -v ../binutils-build && cd ../binutils-build

%CONFIG%
#case "${CLFS_ARCH}" in
#	'x86_64')
#		AR=ar AS=as \
#		../${PACK}/configure \
#			--prefix=/cross-tools \
#			--host=${CLFS_HOST} \
#			--target=${CLFS_TARGET} \
#			--with-sysroot=${CLFS} \
#			--with-lib-path=/tools/lib \
#			--disable-nls \
#			--disable-static \
#			--enable-64-bit-bfd \
#			--disable-werror \
#			--disable-multilib
#	;;
#	*)
#		AR=ar AS=as \
#		../${PACK}/configure \
#			--prefix=/cross-tools \
#			--host=${CLFS_HOST} \
#			--target=${CLFS_TARGET} \
#			--with-sysroot=${CLFS} \
#			--with-lib-path=/tools/lib \
#			--disable-nls \
#			--disable-static \
#			--disable-multilib
#	;;
#esac

../${PACK}/configure \
	--prefix=/tools \
	--with-sysroot=${CLFS} \
	--with-lib-path=/tools/lib \
	--target=${CLFS_TARGET} \
	--disable-nls \
	--disable-werror

%BUILD%
make

case $(uname -m) in
  x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac

%INSTALL%
make install
#cp -v ../${PACK}/include/libiberty.h /tools/include

#######################################
