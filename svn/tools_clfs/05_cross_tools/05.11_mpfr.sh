#######################################

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

patch -Np1 -i ${CLFS_SRC}/${PACK}-fixes-1.patch

LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
  ./configure --prefix=/cross-tools \
              --disable-static \
              --with-gmp=/cross-tools || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
