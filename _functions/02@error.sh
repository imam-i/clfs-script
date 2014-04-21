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
	clfs | tools-clfs) f_umount_clfs ;;
	_tools-clfs)
		rm -f "${logpipe}"
		echo ${_ERR} > ${LOG_DIR}/${ID}/${ID}_flag
	;;
esac

exit ${_ERR}
}

################################################################################
