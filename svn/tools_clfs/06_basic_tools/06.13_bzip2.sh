#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
sed -e 's@^\(all:.*\) test@\1@g' \
    -i ../${PACK}/Makefile

%BUILD%
make CC="${CC} ${BUILD64}" \
     AR="${AR}" \
     RANLIB="${RANLIB}" \
     -C ../${PACK}

%INSTALL%
make -C ../${PACK} PREFIX=/tools install

#######################################
