#######################################

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

CC="${CC} ${BUILD64}" \
  PKG_CONFIG= \
    ./configure --prefix=/tools \
                --build=${CLFS_HOST} \
                --host=${CLFS_TARGET} || return ${?}

make || return ${?}
make install || return ${?}
popd

#######################################