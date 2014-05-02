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
	_tools-clfs)       echo ${_ERR} > ${LOG_DIR}/${ID}/${ID}_flag ;;
	f_log)             exec 1>&6 2>&7 0<&8 6>&- 7>&- 8<&- ;;
esac

exit ${_ERR}
}

################################################################################
