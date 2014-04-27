#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
cd ./${PACK}

cat > config.cache << EOF
fu_cv_sys_stat_statfs2_bsize=yes
gl_cv_func_working_mkstemp=yes
EOF

patch -Np1 -i ${CLFS_SRC}/${PACK}-noman-1.patch

CC="${CC} ${BUILD64}" \
    ./configure --prefix=/tools \
                --build=${CLFS_HOST} \
                --host=${CLFS_TARGET} \
                --enable-install-program=hostname \
                --cache-file=config.cache || return ${?}
make || return ${?}
make install || return ${?}
popd

#######################################
