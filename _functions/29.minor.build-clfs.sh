#!/bin/bash
################################################################################
# Функция "build_clfs"
# Version: 0.1

function f_build_clfs ()
{
local ${_pack_var}
local name="${_NAME}"

while [ true ]
do
	if [ -f ${_script} ]; then
		
		pushd ${BUILD_DIR} > /dev/null
		f_log INFO '======================================================'
		if [ ${ERR_FLAG} -eq 0 ]; then
			f_unarch || ERR_FLAG=${?}
		fi

		install -d ./${name}-build; cd ./${name}-build
		if [ ${ERR_FLAG} -eq 0 ]; then
			f_log INFO "CONFIG: ${_file}"
			eval "$(minor_pars_script_clfs ${_script} 'CONFIG')" 2>&1 | \
				f_log ALL || ERR_FLAG=${?}
		fi

		if [ ${ERR_FLAG} -eq 0 ]; then
			f_log INFO "BUILD: ${_file}"
			eval "$(minor_pars_script_clfs ${_script} 'BUILD')" 2>&1 | \
				f_log ALL || ERR_FLAG=${?}
		fi

		if [ ${ERR_FLAG} -eq 0 ]; then
			f_log INFO "INSTALL: ${_file}"
			eval "$(minor_pars_script_clfs ${_script} 'INSTALL')" 2>&1 | \
				f_log ALL || ERR_FLAG=${?}
		fi
		f_log INFO '======================================================'
		popd > /dev/null
	else
		minor_exec_io_clfs OFF

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

		minor_exec_io_clfs OK
	fi
	local _flag=''
	while [ ${ERR_FLAG} -ne 0 ] && [ "${_flag}" = '' ]
	do
		f_log ERROR "ERROR: ${_file}"
		f_log WARN "Повторить - r"
		f_log WARN "Пропустить - c"
		f_log WARN "Остановить - x"
		printf "\r\t\r" >&6
		read _flag
		case ${_flag} in
			'r')
				ERR_FLAG=0
				[ -d ${BUILD_DIR} ] && rm -Rf ${BUILD_DIR}/*
				local _flag=''
				continue 2
			;;
			'c')
				ERR_FLAG=0
				local _flag=''
			;;
			'x')
				return ${ERR_FLAG}
			;;
		esac
	done
	break
done
}

################################################################################
