#!/bin/bash
################################################################################
# Функция "build_run"
# Version: 0.1

function minor_build_run ()
{
if [ ${ERR_FLAG} -eq 0 ]; then
	f_log INFO "${1}: ${_file}"
	local COMAND="$(minor_pars_script ${_script} ${1})"
	if [ "${COMAND}" != '' ]; then
		eval "${COMAND}" 2>&1 | \
			f_log ALL || ERR_FLAG=${?}
	fi
fi
}

################################################################################
