#######################################

pushd ${BUILD_DIR}
unarch 'mpfr' 'gmp' 'mpc' || return ${?}
cd ./${PACK}

patch -Np1 -i ${CLFS_SRC}/${PACK}-musl.diff

mv -v ../mpfr-* mpfr
mv -v ../gmp-* gmp
mv -v ../mpc-* mpc

mkdir -v ../gcc-build && cd ../gcc-build
../${PACK}/configure --prefix=${CLFS_CROSS_TOOLS} \
                     --build=${CLFS_HOST} \
                     --host=${CLFS_HOST} \
                     --target=${CLFS_TARGET} \
                     --with-sysroot=${CLFS_CROSS_TOOLS}/${CLFS_TARGET} \
                     --disable-nls \
                     --disable-shared \
                     --without-headers \
                     --with-newlib \
                     --disable-decimal-float \
                     --disable-libgomp \
                     --disable-libmudflap \
                     --disable-libssp \
                     --disable-libatomic \
                     --disable-libquadmath \
                     --disable-threads \
                     --enable-languages=c \
                     --disable-multilib \
                     --with-mpfr-include=$(pwd)/../${PACK}/mpfr/src \
                     --with-mpfr-lib=$(pwd)/mpfr/src/.libs \
                     --with-arch=${CLFS_ARM_ARCH} \
                     --with-float=${CLFS_FLOAT} \
                     --with-fpu=${CLFS_FPU} || return ${?}
make all-gcc all-target-libgcc || return ${?}
make install-gcc install-target-libgcc || return ${?}
popd

#######################################
