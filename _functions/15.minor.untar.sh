#!/bin/bash
################################################################################
# Функция "untar"
# Version: 0.1

f_untar ()
{
local message="${1}"; shift
#exec >> ${LOG_FILE}

f_log INFO "f_untar: ${message}"
#color-echo "f_untar: ${message}" ${MAGENTA}
#echo "f_untar: ${message}"
#date >> "${LOG_FILE}"
echo '+++++++++++++++++env+++++++++++++++++++'
env
echo '+++++++++++++++++++++++++++++++++++++++'
echo '++++++++++++++++local++++++++++++++++++'
local
echo '+++++++++++++++++++++++++++++++++++++++'

f_log INFO "Проверка архива: \"${_archive}\""
#color-echo "Проверка архива: \"${_archive}\"" ${CYAN}
bzip2 -t "${CLFS_OUT}/${_archive}" 2>&1 | f_log ALL || ERR_FLAG=${?}

if [ "${ERR_FLAG}" -eq 0 ]; then
	f_log INFO "Распаковка архива: \"${_archive}\""
#	color-echo "Распаковка архива: \"${_archive}\"" ${CYAN}
	tar -xvf "${CLFS_OUT}/${_archive}" -C / 2>&1 | f_log ALL || ERR_FLAG=${?}
fi

# Создание файла: "XX-files"
minor_file ${*}
echo ${ERR_FLAG} > ${CLFS_MINOR_LOG_DIR}/${ID}_flag
}

################################################################################
