#!/bin/bash
################################################################################
# Функция "minor_file_clfs"
# Version: 0.1

minor_file_clfs ()
{
color-echo "Создание файла: \"${ID}-files\"" ${GREEN}
find /{tools/,cross-tools/} \
  | sed -e '/^\/tools\/$/d' \
        -e a'/^\/cross-tools\/$/d' \
  > /tmp/${ID}-files
if [ -n "${1}" ]; then
	diff -n ${LOG_DIR}/${1:0:2}/${1:0:2}-files \
		/tmp/${ID}-files | sed -n '/^\//p' > ${CLFS_MINOR_LOG_DIR}/${ID}-files || true
	rm -f /tmp/${ID}-files
else
	mv /tmp/${ID}-files ${CLFS_MINOR_LOG_DIR}/${ID}-files
fi
}

################################################################################
