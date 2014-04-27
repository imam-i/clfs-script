#!/bin/bash
################################################################################
# Функция "build_clfs"
# Version: 0.1

f_build_clfs ()
{
local ${_pack_var}
local name="${_NAME}"

while [ true ]
do
	echo "${ID}    ${name}    ${_file}"
	if [ -f ${_script} ]; then
		exec 6>&1 7>&2 8<&0
		exec >> ${_log}

		f_unarch || ERR_FLAG=${?}
		. ${_script} | f_log NC || ERR_FLAG=${?}

		exec 1>&6 2>&7 0<&8
		exec 6>&- 7>&- 8<&-
	else
		date
		local _url=`echo ${url} | sed -e "s/_version/${version}/g"`

		# Проверка на наличие патчей
		for (( n=1; n <= 9; n++ ))
		do
			local urlpatch="urlpatch${n}"
			if [ "${!urlpatch}" ]; then
				_url="${_url}"$'\n'`echo ${!urlpatch} | \
						sed -e "s/_version/${version}/g"`
				local md5patch="md5patch${n}"
				md5="${md5}"$'\n'${!md5patch}
			fi
		done

		export name version _url md5
		pushd ${_script}
			f_makepkg_clfs ${_file} || ERR_FLAG=${?}
			f_pacman_clfs ${_file} || ERR_FLAG=${?}
		popd
		unset name version _url md5
	fi
	local _flag=''
	while [ ${ERR_FLAG} -ne 0 ] && [ "${_flag}" = '' ]
	do
		date
		color-echo "ERROR: ${_file}" ${RED}
		color-echo "Повторить - r" ${YELLOW}
		color-echo "Пропустить - c" ${YELLOW}
		color-echo "Остановить - x" ${YELLOW}
		read _flag
		case ${_flag} in
			'r')
				ERR_FLAG=0
				popd || true
				[ -d ${BUILD_DIR} ] && rm -Rf ${BUILD_DIR}/*
				local _flag=''
				continue 2
			;;
			'c')
				popd || true
				ERR_FLAG=0
				local _flag=''
			;;
			'x')	return ${ERR_FLAG} ;;
		esac
	done
	date && break
done &>"${logpipe}"
}

################################################################################
