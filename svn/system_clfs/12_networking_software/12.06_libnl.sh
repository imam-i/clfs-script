#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

CC="${CC} -Os" ./configure --prefix=/usr --host=${CLFS_TARGET} || return ${?}
make || return ${?}
make DESTDIR=${CLFS} install || return ${?}

popd

#######################################
