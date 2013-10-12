#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

sed -i -e 's/@colophon/@@colophon/' \
    -e 's/doc@cygnus.com/doc@@cygnus.com/' bfd/doc/bfd.texinfo || return ${?}

mkdir -v ../binutils-build && cd ../binutils-build
../${PACK}/configure --prefix=${CLFS_CROSS_TOOLS} \
                     --target=${CLFS_TARGET} \
                     --with-sysroot=${CLFS} \
                     --disable-nls \
                     --enable-shared \
                     --disable-multilib || return ${?}
make configure-host || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
