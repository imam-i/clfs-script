%CONFIG%
../${name}-${version}/libstdc++-v3/configure \
	--host=${LFS_TGT}                    \
	--prefix=/tools                      \
	--disable-multilib                   \
	--disable-shared                     \
	--disable-nls                        \
	--disable-libstdcxx-threads          \
	--disable-libstdcxx-pch              \
	--with-gxx-include-dir=/tools/${LFS_TGT}/include/c++/${version}

%BUILD%
make

%INSTALL%
make install
