#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
cd ./${PACK}

./configure --prefix=/cross-tools || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
