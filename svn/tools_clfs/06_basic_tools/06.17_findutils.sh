#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
cd ./${PACK}

cat > config.cache << EOF
gl_cv_func_wcwidth_works=yes
ac_cv_func_fnmatch_gnu=yes
EOF

CC="${CC} ${BUILD64}" \
    ./configure --prefix=/tools \
                --build=${CLFS_HOST} \
                --host=${CLFS_TARGET} \
                --cache-file=config.cache || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
