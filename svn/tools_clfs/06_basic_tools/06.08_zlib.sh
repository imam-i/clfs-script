#######################################

pushd ${BUILD_DIR}
f_unarch || return ${?}
cd ./${PACK}

CC="${CC} ${BUILD64}" \
  ./configure --prefix=/tools || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
