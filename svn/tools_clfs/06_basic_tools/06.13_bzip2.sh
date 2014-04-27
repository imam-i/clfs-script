#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
cd ./${PACK}

sed -e 's@^\(all:.*\) test@\1@g' \
    -i Makefile

make CC="${CC} ${BUILD64}" AR="${AR}" RANLIB="${RANLIB}" || return ${?}
make PREFIX=/tools install || return ${?}
popd

#######################################
