#!/bin/bash
################################################################################
# Функция "untar"
# Version: 0.1

f_untar ()
{
color-echo "f_untar: ${1}" ${MAGENTA}
echo "f_untar: ${1}" >> "${LOG_FILE}"
date >> "${LOG_FILE}"
echo '+++++++++++++++++env+++++++++++++++++++' >> "${LOG_FILE}"
env >> "${LOG_FILE}"
echo '+++++++++++++++++++++++++++++++++++++++' >> "${LOG_FILE}"
echo '++++++++++++++++local++++++++++++++++++' >> "${LOG_FILE}"
local >> "${LOG_FILE}"
echo '+++++++++++++++++++++++++++++++++++++++' >> "${LOG_FILE}"

color-echo "Проверка архива: \"${archive}\"" ${CYAN}
bzip2 -t "${CLFS_OUT}/${archive}" || ERR_FLAG=${?}

if [ "${ERR_FLAG}" -eq 0 ]; then
	color-echo "Распаковка архива: \"${archive}\"" ${CYAN}
	tar -xf "${CLFS_OUT}/${archive}" -C / || ERR_FLAG=${?}
fi

color-echo "Создание файла: \"${ID}-files\"" ${GREEN}
find /{tools,cross-tools} | sed -e '1d' > ${LOG_DIR}/${ID}/${ID}-files

echo ${ERR_FLAG} > ${LOG_DIR}/${ID}/${ID}_flag
date >> "${LOG_FILE}"
}

################################################################################
