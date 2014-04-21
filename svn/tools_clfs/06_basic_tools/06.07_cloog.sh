#######################################

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

CC="${CC} ${BUILD64}" \
  ./configure --prefix=/tools \
              --build=${CLFS_HOST} \
              --host=${CLFS_TARGET} \
              --enable-shared \
              --with-gmp-prefix=/tools \
              --with-isl-prefix=/tools || return ${?}
sed -e '/cmake/d' \
    -i Makefile
make || return ${?}
make install || return ${?}
popd

#######################################
