#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

patch -Np1 -i ${CLFS_SRC}/${name}-${version}-configs-2.patch || return ${?}

cp -v clfs/config.${CLFS_ARCH}.${CLFS_ENDIAN} .config
if [ "${CLFS_ABI}" == "aapcs" ] || [ "${CLFS_ABI}" == "aapcs-linux" ]
then sed -i s/CONFIG_ARM_OABI/CONFIG_ARM_EABI/g .config
fi

sed -e '/.size/d' -i libc/sysdeps/linux/arm/crtn.S || return ${?}

make oldconfig || return ${?}
make || return ${?}
make PREFIX=${CLFS} install || return ${?}
popd

#######################################
