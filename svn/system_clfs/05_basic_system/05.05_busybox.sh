#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

make distclean || return ${?}

patch -Np1 -i ${CLFS_SRC}/${PACK}-musl-1.patch || return ${?}

ARCH="${CLFS_ARCH}" make defconfig || return ${?}
sed -i 's/\(CONFIG_\)\(.*\)\(INETD\)\(.*\)=y/# \1\2\3\4 is not set/g' .config || return ${?}
sed -i 's/\(CONFIG_IFPLUGD\)=y/# \1 is not set/' .config || return ${?}
ARCH="${CLFS_ARCH}" CROSS_COMPILE="${CLFS_TARGET}-" make || return ${?}
ARCH="${CLFS_ARCH}" CROSS_COMPILE="${CLFS_TARGET}-" make  \
  CONFIG_PREFIX="${CLFS}/targetfs" install || return ${?}

cp examples/depmod.pl ${CLFS_CROSS_TOOLS}/bin && \
chmod 755 ${CLFS_CROSS_TOOLS}/bin/depmod.pl || return ${?}
popd

#######################################
