#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

mkdir -v build && cd build || return ${?}

CC="${CC} -Os" \
  ../configure --prefix=/usr \
               --with-root-prefix="" \
               --host=${CLFS_TARGET} \
               --disable-tls \
               --disable-debugfs \
               --disable-e2initrd-helper \
               --disable-nls || return ${?}
make || return ${?}
make DESTDIR=${CLFS}/targetfs install || return ${?}
make DESTDIR=${CLFS}/targetfs install-libs || return ${?}

popd

#######################################
