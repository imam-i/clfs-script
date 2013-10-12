#######################################

pushd ${BUILD_DIR}
unarch || return ${?}
cd ./${PACK}

# -------------------------------------

#cp ${CLFS_SRC}/${name}_config ./.config

# -------------------------------------

patch -Np1 -i ${CLFS_SRC}/${name}-0.9.31-configs-2.patch || return ${?}

cp -v clfs/config.${CLFS_ARCH}.${CLFS_ENDIAN} .config || return ${?}
if [ "${CLFS_ABI}" == "aapcs" ] || [ "${CLFS_ABI}" == "aapcs-linux" ]; then
    sed -e '/CONFIG_ARM_OABI/c \# CONFIG_ARM_OABI is not set' \
        -e '/CONFIG_ARM_EABI/c \CONFIG_ARM_EABI=y' \
        -i .config || return ${?}
fi

sed -e '/UCLIBC_HAS_NFTW/c \UCLIBC_HAS_NFTW=y' -i .config || return ${?}

# -------------------------------------

sed -e '/.size/d' -i libc/sysdeps/linux/arm/crtn.S || return ${?}

yes '' | make oldconfig || return ${?}
make || return ${?}
make PREFIX=${CLFS} install || return ${?}
popd

#######################################
