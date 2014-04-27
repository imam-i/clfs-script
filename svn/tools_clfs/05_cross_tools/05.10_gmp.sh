#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
cd ./${PACK}

./configure --prefix=/cross-tools \
            --enable-cxx \
            --disable-static || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
