#######################################

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

#patch -Np1 -i ${CLFS_SRC}/${PACK}-musl-1.patch

./configure --prefix=/cross-tools \
            --enable-cxx \
            --disable-static || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
