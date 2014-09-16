#!/bin/bash
################################################################################
# Функция "build"
# Version: 0.1

function minor_build ()
{
local ${_pack_var}
local name="${_NAME}"
local extract="extract_${BOOK}_${ID}"

while [ true ]
do
	if [ -f ${_script} ]; then

		f_log INFO '======================================================'

		f_download `echo ${!extract} | sed -e 's/;/ /g'` || ERR_FLAG=${?}
		local ${_pack_var}

		pushd ${BUILD_DIR} > /dev/null
		if [ ${ERR_FLAG} -eq 0 ]; then
			if [ "${PWD}" = "${BUILD_DIR}" ]; then
				rm -Rf ./*
			fi
			f_unarch `echo ${!extract} | sed -e 's/;/ /g'` || ERR_FLAG=${?}
			local ${_pack_var}
		fi

		install -d ./${name}-build; cd ./${name}-build

		minor_build_run 'CONFIG'
		minor_build_run 'BUILD'
		minor_build_run 'CHECK'
		minor_build_run 'INSTALL'

#		if [ ${ERR_FLAG} -eq 0 ]; then
#			f_log INFO "CONFIG: ${_file}"
#			local COMAND="$(minor_pars_script ${_script} 'CONFIG')"
#			if [ "${COMAND}" != '' ]; then
#		#		echo "${COMAND}"
#				eval "${COMAND}" 2>&1 | \
#					f_log ALL || ERR_FLAG=${?}
#			fi
#		fi

#		if [ ${ERR_FLAG} -eq 0 ]; then
#			f_log INFO "BUILD: ${_file}"
#			local COMAND="$(minor_pars_script ${_script} 'BUILD')"
#			if [ "${COMAND}" != '' ]; then
#		#		echo "${COMAND}"
#				eval "${COMAND}" 2>&1 | \
#					f_log ALL || ERR_FLAG=${?}
#			fi
#		fi

#		if [ ${ERR_FLAG} -eq 0 ]; then
#			f_log INFO "CHECK: ${_file}"
#			local COMAND="$(minor_pars_script ${_script} 'CHECK')"
#			if [ "${COMAND}" != '' ]; then
#				eval "${COMAND}" 2>&1 | \
#					f_log ALL || ERR_FLAG=${?}
#			fi
#		fi

#		if [ ${ERR_FLAG} -eq 0 ]; then
#			f_log INFO "INSTALL: ${_file}"
#			local COMAND="$(minor_pars_script ${_script} 'INSTALL')"
#			if [ "${COMAND}" != '' ]; then
#		#		echo "${COMAND}"
#				eval "${COMAND}" 2>&1 | \
#					f_log ALL || ERR_FLAG=${?}
#			fi
#		fi
		popd > /dev/null
	else
		minor_exec_io OFF

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
			f_makepkg ${_file} || ERR_FLAG=${?}
			f_pacman ${_file} || ERR_FLAG=${?}
		popd
		unset name version _url md5

		minor_exec_io OK
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
