%CONFIG%
../${name}-${version}/configure \
	--prefix=/tools         \
	--enable-install-program=hostname

%BUILD%
make

%CHECK%
make RUN_EXPENSIVE_TESTS=yes check

%INSTALL%
make install

# чтобы не сбивалось время в логе
#export TZ=/etc/localtime
