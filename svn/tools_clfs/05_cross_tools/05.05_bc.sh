#######################################

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

#patch -Np1 -i ${CLFS_SRC}/${PACK}-musl-1.patch

./configure --prefix=${CLFS_CROSS_TOOLS} || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
