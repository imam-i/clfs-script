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
                       --enable-shared \
                       --disable-static \
                       --enable-languages=c,c++ \
                       --enable-__cxa_atexit \
                       --enable-c99 \
                       --enable-long-long \
                       --enable-threads=posix \
                       --disable-multilib \
                       --with-mpc=/cross-tools \
                       --with-mpfr=/cross-tools \
                       --with-gmp=/cross-tools \
                       --with-cloog=/cross-tools \
                       --enable-cloog-backend=isl \
                       --with-isl=/cross-tools \
                       --disable-isl-version-check \
                       --with-system-zlib \
                       --enable-checking=release \
                       --enable-libstdcxx-time || return ${?}
make AS_FOR_TARGET="${CLFS_TARGET}-as" \
     LD_FOR_TARGET="${CLFS_TARGET}-ld" || return ${?}
make install || return ${?}
popd

#######################################
