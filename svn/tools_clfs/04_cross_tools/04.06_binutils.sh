#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

patch -Np1 -i ${CLFS_SRC}/${PACK}-musl-1.patch

mkdir -v ../binutils-build && cd ../binutils-build
../${PACK}/configure --prefix=${CLFS_CROSS_TOOLS} \
                     --target=${CLFS_TARGET} \
                     --with-sysroot=${CLFS_CROSS_TOOLS}/${CLFS_TARGET} \
                     --disable-nls \
                     --disable-multilib || return ${?}
make configure-host || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
