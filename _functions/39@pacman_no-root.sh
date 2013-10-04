#!/bin/bash
################################################################################
# Функция "pacman_no-root"
# Version: 0.1

pacman_no_root ()
{

if [ -f /opt/bin/pacman ]; then
	return 0
fi

unset _pack_var
_pack_var=`pack_var 'clfs.my.pacman'`
local ${_pack_var}

pushd ${BUILD_DIR}
	unarch
	cd ./${PACK}

	sed -e 's/myuid > 0/myuid < 0/' -i ./src/pacman/pacman.c

	./configure --prefix=/opt
	make
	make install
popd

clear_per "${_pack_var}"
unset _pack_var
}

################################################################################
