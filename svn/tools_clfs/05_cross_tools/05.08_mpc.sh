#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

LDFLAGS="-Wl,-rpath,${CLFS}/cross-tools/lib" \
  ./configure --prefix=${CLFS}/cross-tools \
              --with-gmp=${CLFS}/cross-tools \
              --with-mpfr=${CLFS}/cross-tools || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
