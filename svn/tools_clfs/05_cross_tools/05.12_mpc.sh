#######################################

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
  ./configure --prefix=/cross-tools \
              --disable-static \
              --with-gmp=/cross-tools \
              --with-mpfr=/cross-tools || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
