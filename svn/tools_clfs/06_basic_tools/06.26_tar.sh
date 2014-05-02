#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
#cd ./${PACK}

%CONFIG%
cat > config.cache << EOF
gl_cv_func_wcwidth_works=yes
gl_cv_func_btowc_eof=yes
ac_cv_func_malloc_0_nonnull=yes
gl_cv_func_mbrtowc_incomplete_state=yes
gl_cv_func_mbrtowc_nul_retval=yes
gl_cv_func_mbrtowc_null_arg1=yes
gl_cv_func_mbrtowc_null_arg2=yes
gl_cv_func_mbrtowc_retval=yes
gl_cv_func_wcrtomb_retval=yes
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
