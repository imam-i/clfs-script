#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

make distclean || return ${?}

patch -Np1 -i ${CLFS_SRC}/${name}-${version}-config-1.patch || return ${?}
cp -v clfs/config .config || return ${?}

make oldconfig || return ${?}
make CROSS_COMPILE="${CLFS_TARGET}-" || return ${?}
make CROSS_COMPILE="${CLFS_TARGET}-" \
     CONFIG_PREFIX="${CLFS}" install || return ${?}

cp examples/depmod.pl ${CLFS}/cross-tools/bin || return ${?}
chmod 755 ${CLFS}/cross-tools/bin/depmod.pl || return ${?}
popd

#######################################
