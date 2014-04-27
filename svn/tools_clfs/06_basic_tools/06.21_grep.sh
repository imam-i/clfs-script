#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
cd ./${PACK}

CC="${CC} ${BUILD64}" \
    ./configure --prefix=/tools \
                --build=${CLFS_HOST} \
                --host=${CLFS_TARGET} \
                --without-included-regex || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
