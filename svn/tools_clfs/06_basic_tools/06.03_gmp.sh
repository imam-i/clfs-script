#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
cd ./${PACK}

HOST_CC=gcc \
  CC="${CC} ${BUILD64}" \
  CXX="${CXX} ${BUILD64}" \
    ./configure --prefix=/tools \
                --build=${CLFS_HOST} \
                --host=${CLFS_TARGET} \
                --enable-cxx || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
