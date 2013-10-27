#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

patch -Np1 -i ${CLFS_SRC}/${PACK}-update-2.patch || return ${?}

make get || return ${?}
make STRIP=yes || return ${?}
make DESTDIR=${CLFS}/targetfs install || return ${?}
popd

#######################################
