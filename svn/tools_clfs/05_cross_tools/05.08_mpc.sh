#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

LDFLAGS="-Wl,-rpath,${CLFS_CROSS_TOOLS}/lib" \
  ./configure --prefix=${CLFS_CROSS_TOOLS} \
              --with-gmp=${CLFS_CROSS_TOOLS} \
              --with-mpfr=${CLFS_CROSS_TOOLS} || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
