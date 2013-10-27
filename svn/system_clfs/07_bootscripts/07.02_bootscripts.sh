#######################################
#local _name=$(echo ${LINUX_LFS} | cut -d\; -f2)
#local _version=$(echo ${LINUX_LFS} | cut -d\; -f3)

#pushd ${BUILD_DIR}
#unarch || return ${?}
pushd ${CLFS_SRC}/bootscripts-embedded || return ${?}

make DESTDIR=${CLFS}/targetfs install-bootscripts || return ${?}
install -dv ${CLFS}/targetfs/etc/init.d || return ${?}
ln -sv ../rc.d/startup ${CLFS}/targetfs/etc/init.d/rcS || return ${?}

popd

#######################################
