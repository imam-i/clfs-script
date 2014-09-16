#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./wireless_tools.${version}

sed -i s/gcc/\$\{CLFS\_TARGET\}\-gcc/g Makefile || return ${?}
sed -i s/\ ar/\ \$\{CLFS\_TARGET\}\-ar/g Makefile || return ${?}
sed -i s/ranlib/\$\{CLFS\_TARGET\}\-ranlib/g Makefile || return ${?}

make PREFIX=${CLFS}/targetfs/usr || return ${?}
make install PREFIX=${CLFS}/targetfs/usr || return ${?}

popd

#######################################
