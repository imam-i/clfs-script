#!/bin/bash
################################################################################
# Функция "build_run"
# Version: 0.1

minor_build_run ()
{
local CLFS_FLAG="${FUNCNAME}"

if [ ${ERR_FLAG} -eq 0 ]; then
	local COMAND="$(minor_pars_script ${pkg_dir}/${NAME}.${BOOK} ${1})"
	if [ "${COMAND}" != '' ]; then
		minor_log INFO "${1}: ${NAME}.${BOOK}"
		eval "${COMAND}" 2>&1 | minor_log ALL
	fi
fi
}

################################################################################
