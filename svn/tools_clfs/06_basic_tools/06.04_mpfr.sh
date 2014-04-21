#######################################

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

patch -Np1 -i ${CLFS_SRC}/${PACK}-fixes-1.patch

CC="${CC} ${BUILD64}" \
  ./configure --prefix=/tools \
              --build=${CLFS_HOST} \
              --host=${CLFS_TARGET} \
              --enable-shared || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
