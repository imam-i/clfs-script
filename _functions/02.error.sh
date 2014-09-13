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
	_tools-clfs)       echo ${_ERR} > ${CLFS_MINOR_LOG_DIR}/${ID}_flag ;;
	f_log)             minor_exec_io_clfs OFF ;;
esac

exit ${_ERR}
}

################################################################################
