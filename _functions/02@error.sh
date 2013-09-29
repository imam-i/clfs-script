#!/bin/bash
################################################################################
# Функция "_ERROR"
# Version: 0.1

_ERROR ()
{
local _ERR=${?}

color-echo "Ошибка № ${_ERR} в ${CLFS_FLAG} !!!" ${RED}

read

case "${CLFS_FLAG}" in
	clfs | tools-clfs) umount_clfs ;;
	_tools-clfs) rm -f "${logpipe}" ;;
esac

exit ${_ERR}
}

################################################################################
