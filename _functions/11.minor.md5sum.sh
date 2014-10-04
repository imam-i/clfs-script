#!/bin/bash
################################################################################
# Функция "md5sum"
# Version: 0.1

minor_md5sum ()
{
	local url="${1}"
	local md5="${2}"
	local _arch=${CLFS_SRC}/`basename ${url}`

	minor_log INFO 'MD5SUM: '`basename ${url}`

	pushd ${CLFS_SRC} > /dev/null 2>&1
		if [ -n "${md5}" ]; then
			eval "echo ${md5}  ${_arch} | md5sum -c" 2>&1 | minor_log ALL
			if [ "${ERR_FLAG}" -gt 0 ]; then
				minor_log ERROR "md5 file ${_arch}: `md5sum ${_arch} | cut -d' ' -f1`"
				minor_log ERROR "Ожидался: ${md5}"
				return ${ERR_FLAG}
			fi
		else
			minor_log INFO "md5sum ${_arch}"
			md5sum ${_arch} 2>&1 | minor_log ALL
			popd > /dev/null 2>&1
			return 1
		fi
	popd > /dev/null 2>&1
}

################################################################################
