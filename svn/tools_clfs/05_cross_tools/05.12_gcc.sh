#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

mkdir -v ../gcc-build && cd ../gcc-build
AR=ar LDFLAGS="-Wl,-rpath,${CLFS_CROSS_TOOLS}/lib" \
  ../${PACK}/configure --prefix=${CLFS_CROSS_TOOLS} \
                       --build=${CLFS_HOST} \
                       --target=${CLFS_TARGET} \
                       --host=${CLFS_HOST} \
                       --with-sysroot=${CLFS} \
                       --disable-nls \
                       --enable-shared \
                       --enable-languages=c \
                       --enable-c99 \
                       --enable-long-long \
                       --with-mpfr=${CLFS_CROSS_TOOLS} \
                       --with-gmp=${CLFS_CROSS_TOOLS} \
                       --with-mpc=${CLFS_CROSS_TOOLS} \
                       --disable-multilib \
                       --with-abi=${CLFS_ABI} \
                       --with-arch=${CLFS_ARM_ARCH} \
                       --with-mode=${CLFS_ARM_MODE} \
                       --with-float=${CLFS_FLOAT} \
                       --with-fpu=${CLFS_FPU} || return ${?}
make || return ${?}
make install || return ${?}
cp -v ${CLFS_CROSS_TOOLS}/${CLFS_TARGET}/lib/libgcc_s.so.1 ${CLFS}/lib
popd

#######################################
