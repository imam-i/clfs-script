#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
cat > config.cache << EOF
gl_cv_func_wcwidth_works=yes
ac_cv_func_fnmatch_gnu=yes
EOF

CC="${CC} ${BUILD64}" \
    ../${PACK}/configure \
	--prefix=/tools \
	--build=${CLFS_HOST} \
	--host=${CLFS_TARGET} \
	--cache-file=config.cache

%BUILD%
make

%INSTALL%
make install

#######################################
