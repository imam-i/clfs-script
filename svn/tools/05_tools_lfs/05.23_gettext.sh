%CONFIG%
EMACS="no" ../${name}-${version}/gettext-tools/configure \
	--prefix=/tools \
	--disable-shared

%BUILD%
make -C gnulib-lib
make -C src msgfmt
make -C src msgmerge
make -C src xgettext

%INSTALL%
cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin
