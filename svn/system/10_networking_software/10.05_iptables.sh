#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

./autogen.sh || return ${?}

CC="${CC} -Os" \
  ./configure --prefix=/usr \
              --host=${CLFS_TARGET} \
              --libexecdir=/lib/iptables \
              --without-kernel \
              --enable-libipq \
              --enable-shared || return ${?}

make || return ${?}
make DESTDIR=${CLFS}/targetfs install || return ${?}

popd

#######################################
