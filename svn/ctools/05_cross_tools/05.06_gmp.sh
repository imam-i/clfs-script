#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

CPPFLAGS=-fexceptions \
  ./configure --build=${CLFS_HOST} \
              --prefix=${CLFS}/cross-tools || return ${?}
make || return ${?}
make check || return ${?}
make install || return ${?}
popd

#######################################
