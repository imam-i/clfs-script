#######################################

pushd ${BUILD_DIR}
#unarch 'mpfr' 'gmp' 'mpc' || return ${?}
f_unarch || return ${?}
cd ./${PACK}

patch -Np1 -i ${CLFS_SRC}/${PACK}-branch_update-2.patch
case "${CLFS_ARCH}" in
	'x86_64') patch -Np1 -i ${CLFS_SRC}/${PACK}-pure64_specs-1.patch ;;
	*) patch -Np1 -i ${CLFS_SRC}/${PACK}-specs-1.patch ;;
esac

echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h

touch /tools/include/limits.h

mkdir -v ../gcc-build && cd ../gcc-build
AR=ar LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
  ../${PACK}/configure --prefix=/cross-tools \
                       --build=${CLFS_HOST} \
                       --host=${CLFS_HOST} \
                       --target=${CLFS_TARGET} \
                       --with-sysroot=${CLFS} \
                       --with-local-prefix=/tools \
                       --with-native-system-header-dir=/tools/include \
                       --disable-nls \
                       --disable-shared \
                       --with-mpfr=/cross-tools \
                       --with-gmp=/cross-tools \
                       --with-isl=/cross-tools \
                       --with-cloog=/cross-tools \
                       --with-mpc=/cross-tools \
                       --without-headers \
                       --with-newlib \
                       --disable-decimal-float \
                       --disable-libgomp \
                       --disable-libmudflap \
                       --disable-libssp \
                       --disable-threads \
                       --disable-multilib \
                       --disable-libatomic \
                       --disable-libitm \
                       --disable-libsanitizer \
                       --disable-libquadmath \
                       --disable-target-libiberty \
                       --disable-target-zlib \
                       --with-system-zlib \
                       --enable-cloog-backend=isl \
                       --disable-isl-version-check \
                       --enable-languages=c \
                       --enable-checking=release || return ${?}
make all-gcc all-target-libgcc || return ${?}
make install-gcc install-target-libgcc || return ${?}
popd

#######################################
