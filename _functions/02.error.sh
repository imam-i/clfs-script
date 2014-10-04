#!/bin/bash
################################################################################
# Функция "_ERROR"
# Version: 0.1

_ERROR ()
{
ERR_FLAG=${?}

case "${CLFS_FLAG}" in
	minor_build_run | minor_build | minor_download | minor_unarch)
#		ERR_FLAG=${_ERR}
		return 0
	;;
	minor_scripts)
		minor_exec_io OFF
		echo ${ERR_FLAG} > ${CLFS_MAIN_LOG_DIR}/${ID}.flag
	;;
	su_tools)
		minor_exec_io OFF 2> /dev/null || true
		echo ${ERR_FLAG} > ${CLFS_LOG}/tools.flag
	;;
esac

color-echo $'\r'"Ошибка № ${ERR_FLAG} в ${CLFS_FLAG} !!!" ${RED}

read

case "${CLFS_FLAG}" in
	clfs | main_tools)
		main_umount
	;;
#	minor_scripts)
#		minor_exec_io OFF
#		echo ${ERR_FLAG} > ${CLFS_MINOR_LOG_DIR}/${ID}_flag
#	;;
#	f_log)             minor_exec_io OFF ;;
esac

exit ${ERR_FLAG}
}

################################################################################
