#######################################

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

patch -Np1 -i ${CLFS_SRC}/${PACK}-bash_fix-1.patch

./configure --prefix=/cross-tools \
            --without-debug \
            --without-shared || return ${?}

make -C include || return ${?}
make -C progs tic || return ${?}
install -v -m755 progs/tic /cross-tools/bin || return ${?}
popd

#######################################
