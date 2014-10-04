#!/bin/bash
################################################################################
# Функция "minor_file"
# Version: 0.1

minor_file ()
{
#color-echo "Создание файла: \"${ID}-files\"" ${GREEN}
minor_log INFO "Создание файла: ${ID} files"
find /tools/ \
  | sed -e '/^\/tools\/$/d' \
  > /tmp/${ID}-files
if [ -n "${1}" ]; then
	diff -n ${LOG_DIR}/${1:0:2}/files \
		/tmp/${ID}-files | sed -n '/^\//p' > ${CLFS_MINOR_LOG_DIR}/files || true
	rm -f /tmp/${ID}-files
else
	mv /tmp/${ID}-files ${CLFS_MINOR_LOG_DIR}/files
fi
}

################################################################################
