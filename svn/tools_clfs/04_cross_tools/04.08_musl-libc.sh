#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

CC=${CLFS_TARGET}-gcc ./configure \
  --prefix=/ \
  --target=${CLFS_TARGET} || return ${?}

CC=${CLFS_TARGET}-gcc make || return ${?}
DESTDIR=${CLFS_CROSS_TOOLS}/${CLFS_TARGET} make install || return ${?}
popd

#######################################
