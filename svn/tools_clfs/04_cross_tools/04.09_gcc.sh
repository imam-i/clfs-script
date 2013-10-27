#######################################

pushd ${BUILD_DIR}
unarch 'mpfr' 'gmp' 'mpc' || return ${?}
cd ./${PACK}

patch -Np1 -i ${CLFS_SRC}/${PACK}-musl.diff

mv -v ../mpfr-* mpfr
mv -v ../gmp-* gmp
mv -v ../mpc-* mpc

mkdir -v ../gcc-build && cd ../gcc-build
../${PACK}/configure \
  --prefix=${CLFS_CROSS_TOOLS} \
  --build=${CLFS_HOST} \
  --target=${CLFS_TARGET} \
  --host=${CLFS_HOST} \
  --with-sysroot=${CLFS_CROSS_TOOLS}/${CLFS_TARGET} \
  --disable-nls \
  --enable-languages=c \
  --enable-c99 \
  --enable-long-long \
  --disable-libmudflap \
  --disable-multilib \
  --with-mpfr-include=$(pwd)/../${PACK}/mpfr/src \
  --with-mpfr-lib=$(pwd)/mpfr/src/.libs \
  --with-arch=${CLFS_ARM_ARCH} \
  --with-float=${CLFS_FLOAT} \
  --with-fpu=${CLFS_FPU} || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
