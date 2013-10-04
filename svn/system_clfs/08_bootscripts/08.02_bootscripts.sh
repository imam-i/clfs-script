#######################################
#local _name=$(echo ${LINUX_LFS} | cut -d\; -f2)
#local _version=$(echo ${LINUX_LFS} | cut -d\; -f3)

#pushd ${BUILD_DIR}
#unarch || return ${?}
pushd ${CLFS_SRC}/bootscripts-embedded || return ${?}

make DESTDIR=${CLFS} install-bootscripts || return ${?}
install -dv ${CLFS}/etc/init.d || return ${?}
ln -sv ../rc.d/startup ${CLFS}/etc/init.d/rcS || return ${?}

popd

#######################################
