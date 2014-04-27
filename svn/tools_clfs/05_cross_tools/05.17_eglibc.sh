#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
cd ./${name}-${version}

sed -r -i 's/(3..89..)/\1 | 4.*/' configure

mkdir -v ../glibc-build && cd ../glibc-build

echo "libc_cv_ssp=no" > config.cache

BUILD_CC="gcc" \
  CC="${CLFS_TARGET}-gcc ${BUILD64}" \
  AR="${CLFS_TARGET}-ar" \
  RANLIB="${CLFS_TARGET}-ranlib" \
    ../${name}-${version}/configure --prefix=/tools \
                                    --host=${CLFS_TARGET} \
                                    --build=${CLFS_HOST} \
                                    --disable-profile \
                                    --with-tls \
                                    --enable-kernel=2.6.32 \
                                    --with-__thread \
                                    --with-binutils=/cross-tools/bin \
                                    --with-headers=/tools/include \
                                    --enable-obsolete-rpc \
                                    --cache-file=config.cache || return ${?}

make || return ${?}
make install || return ${?}
popd

#######################################
