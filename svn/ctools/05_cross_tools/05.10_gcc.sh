#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

mkdir -v ../gcc-build && cd ../gcc-build
AR=ar LDFLAGS="-Wl,-rpath,${CLFS}/cross-tools/lib" \
  ../${PACK}/configure --prefix=${CLFS}/cross-tools \
                       --build=${CLFS_HOST} \
                       --host=${CLFS_HOST} \
                       --target=${CLFS_TARGET} \
                       --with-sysroot=${CLFS} \
                       --disable-nls \
                       --disable-shared \
                       --with-mpfr=${CLFS}/cross-tools \
                       --with-gmp=${CLFS}/cross-tools \
                       --with-mpc=${CLFS}/cross-tools \
                       --without-headers \
                       --with-newlib \
                       --disable-decimal-float \
                       --disable-libgomp \
                       --disable-libmudflap \
                       --disable-libssp \
                       --disable-threads \
                       --enable-languages=c \
                       --disable-multilib \
                       --with-abi=${CLFS_ABI} \
                       --with-arch=${CLFS_ARM_ARCH} \
                       --with-mode=${CLFS_ARM_MODE} \
                       --with-float=${CLFS_FLOAT} \
                       --with-fpu=${CLFS_FPU} || return ${?}
make all-gcc all-target-libgcc || return ${?}
make install-gcc install-target-libgcc || return ${?}
popd

#######################################
