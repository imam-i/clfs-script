#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
cd ./${PACK}/gettext-tools

echo "gl_cv_func_wcwidth_works=yes" > config.cache

CC="${CC} ${BUILD64}" \
  CXX="${CXX} ${BUILD64}" \
    ./configure --prefix=/tools \
                --disable-shared \
                --build=${CLFS_HOST} \
                --host=${CLFS_TARGET} \
                --cache-file=config.cache || return ${?}
make -C gnulib-lib || return ${?}
make -C src msgfmt msgmerge xgettext || return ${?}

cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin || return ${?}
popd

#######################################
