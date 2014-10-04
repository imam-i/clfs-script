%CONFIG%
../${name}-${version}/configure \
	--prefix=/tools \
	--with-shared	\
	--without-debug	\
	--without-ada	\
	--enable-widec  \
	--enable-overwrite

%BUILD%
make

%INSTALL%
make install
