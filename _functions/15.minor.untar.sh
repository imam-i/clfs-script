#!/bin/bash
################################################################################
# Функция "untar"
# Version: 0.1

f_untar ()
{
local message="${1}"; shift
color-echo "f_untar: ${message}" ${MAGENTA}
echo "f_untar: ${message}" >> "${LOG_FILE}"
#date >> "${LOG_FILE}"
echo '+++++++++++++++++env+++++++++++++++++++' >> "${LOG_FILE}"
env >> "${LOG_FILE}"
echo '+++++++++++++++++++++++++++++++++++++++' >> "${LOG_FILE}"
echo '++++++++++++++++local++++++++++++++++++' >> "${LOG_FILE}"
local >> "${LOG_FILE}"
echo '+++++++++++++++++++++++++++++++++++++++' >> "${LOG_FILE}"

color-echo "Проверка архива: \"${_archive}\"" ${CYAN}
#bzip2 -t "${CLFS_OUT}/${_archive}" || ERR_FLAG=${?}

if [ "${ERR_FLAG}" -eq 0 ]; then
	color-echo "Распаковка архива: \"${_archive}\"" ${CYAN}
	tar -xf "${CLFS_OUT}/${_archive}" -C / || ERR_FLAG=${?}
fi

# Создание файла: "XX-files"
minor_file_clfs ${*}
echo ${ERR_FLAG} > ${CLFS_MINOR_LOG_DIR}/${ID}_flag
}

################################################################################
