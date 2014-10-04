%CONFIG%
../${name}-${version}/configure        \
	--prefix=/tools                \
	--without-python               \
	--disable-makeinstall-chown    \
	--without-systemdsystemunitdir \
	PKG_CONFIG=""

%BUILD%
make

%INSTALL%
make install
