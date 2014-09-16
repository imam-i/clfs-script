%CONFIG%
make -C ../${name}-${version}/ mrproper

%BUILD%
make -C ../${name}-${version}/ headers_check

%INSTALL%
make -C ../${name}-${version}/ INSTALL_HDR_PATH=/tools headers_install
