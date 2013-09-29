#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

mkdir -v ../gcc-build && cd ../gcc-build
AR=ar LDFLAGS="-Wl,-rpath,${CLFS}/cross-tools/lib" \
  ../${PACK}/configure --prefix=${CLFS}/cross-tools \
                       --build=${CLFS_HOST} \
                       --target=${CLFS_TARGET} \
                       --host=${CLFS_HOST} \
                       --with-sysroot=${CLFS} \
                       --disable-nls \
                       --enable-shared \
                       --enable-languages=c \
                       --enable-c99 \
                       --enable-long-long \
                       --with-mpfr=${CLFS}/cross-tools \
                       --with-gmp=${CLFS}/cross-tools \
                       --with-mpc=${CLFS}/cross-tools \
                       --disable-multilib \
                       --with-abi=${CLFS_ABI} \
                       --with-arch=${CLFS_ARM_ARCH} \
                       --with-mode=${CLFS_ARM_MODE} \
                       --with-float=${CLFS_FLOAT} \
                       --with-fpu=${CLFS_FPU} || return ${?}
make || return ${?}
make install || return ${?}
cp -v ${CLFS}/cross-tools/${CLFS_TARGET}/lib/libgcc_s.so.1 ${CLFS}/lib
popd

#######################################
