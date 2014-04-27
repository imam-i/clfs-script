#######################################

#pushd ${BUILD_DIR}
#f_unarch || return ${?}
cd ./${name}${version/./}

patch -Np1 -i ${CLFS_SRC}/${PACK}-branch_update-2.patch

cat > src/auto/config.cache << "EOF"
vim_cv_getcwd_broken=no
vim_cv_memmove_handles_overlap=yes
vim_cv_stat_ignores_slash=no
vim_cv_terminfo=yes
vim_cv_toupper_broken=no
vim_cv_tty_group=world
EOF

echo '#define SYS_VIMRC_FILE "/tools/etc/vimrc"' >> src/feature.h

CC="${CC} ${BUILD64}" \
  CXX="${CXX} ${BUILD64}" \
    ./configure --prefix=/tools \
                --build=${CLFS_HOST} \
                --host=${CLFS_TARGET} \
                --enable-multibyte \
                --enable-gui=no \
                --disable-gtktest \
                --disable-xim \
                --with-features=normal \
                --disable-gpm \
                --without-x \
                --disable-netbeans \
                --with-tlib=ncurses || return ${?}
make || return ${?}
make install || return ${?}

ln -sv vim /tools/bin/vi
cat > /tools/etc/vimrc << "EOF"
" Begin /tools/etc/vimrc

set nocompatible
set backspace=2
set ruler
syntax on

" End /tools/etc/vimrc
EOF
popd

#######################################
