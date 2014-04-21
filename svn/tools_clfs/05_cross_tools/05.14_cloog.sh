#######################################

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

#patch -Np1 -i ${CLFS_SRC}/${PACK}-musl-1.patch

LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
  ./configure --prefix=/cross-tools \
              --disable-static \
              --with-gmp-prefix=/cross-tools \
              --with-isl-prefix=/cross-tools || return ${?}
sed -e '/cmake/d' \
    -i Makefile
make || return ${?}
make install || return ${?}
popd

#######################################
