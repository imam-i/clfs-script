#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

make distclean || return ${?}

patch -Np1 -i ${CLFS_SRC}/${name}-1.21.0-config-1.patch || return ${?}
cp -v clfs/config .config || return ${?}

yes '' | make oldconfig || return ${?}
make CROSS_COMPILE="${CLFS_TARGET}-" || return ${?}
make CROSS_COMPILE="${CLFS_TARGET}-" \
     CONFIG_PREFIX="${CLFS}" install || return ${?}

cp examples/depmod.pl ${CLFS_CROSS_TOOLS}/bin || return ${?}
chmod 755 ${CLFS_CROSS_TOOLS}/bin/depmod.pl || return ${?}
popd

#######################################
