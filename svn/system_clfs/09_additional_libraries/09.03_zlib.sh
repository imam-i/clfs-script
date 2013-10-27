#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

cp configure{,.orig} &&
sed -e 's/-O3/-Os/g' configure.orig > configure || return ${?}

./configure --shared || return ${?}
make || return ${?}
make prefix=${CLFS_CROSS_TOOLS}/${CLFS_TARGET} install || return ${?}

#mv -v ${CLFS}/usr/lib/libz.so.* ${CLFS}/lib || return ${?}
#ln -svf ../../lib/libz.so.1 ${CLFS}/usr/lib/libz.so || return ${?}
popd

#######################################
