#!/bin/bash
################################################################################
# Функция "su_clfs"
# Version: 0.1

su_clfs ()
{
[ "${ERR_FLAG}" -gt 0 ] && return ${ERR_FLAG}

[ "${SU_FLAG}" -eq 0 ] && return 0

if [ -z "${1}" ]; then
	if [ "${SU_FLAG}" -gt 0 ]; then
		color-echo "!!! SU - CLFS !!!" ${YELLOW}
		date > "${CLFS_LOG}/su.log"
	else
		return 0
	fi
fi

# Удаляем запуск скрипта.
sed -e "/\/_su\/_ctools.sh/d" \
    -e "/\/_su\/_csystem.sh/d" \
    -e '/^exit/d' \
    -i /home/clfs/.bashrc

# Входим в su
su - clfs

date > "${CLFS_LOG}/su.log"
}

################################################################################
