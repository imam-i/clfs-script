#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

patch -Np1 -i ${CLFS_SRC}/${name}-${version}-update-1.patch || return ${?}

make get || return ${?}
make || return ${?}
make DESTDIR=${CLFS} install || return ${?}
popd

#######################################
