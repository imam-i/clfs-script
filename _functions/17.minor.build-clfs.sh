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
	exec 6>&1 7>&2 8<&0
	if [ -f ${_script} ]; then
		
		pushd ${BUILD_DIR}
		if [ ${ERR_FLAG} -eq 0 ]; then
			exec >> ${CLFS_PAK_LOG_DIR}/00_extract.log
			exec 2>> ${CLFS_PAK_LOG_DIR}/00_extract.error.log
			f_unarch || ERR_FLAG=${?}
		fi

	#	. ${_script} || ERR_FLAG=${?}
		install -d ./${name}-build; cd ./${name}-build
		if [ ${ERR_FLAG} -eq 0 ]; then
			exec >> ${CLFS_PAK_LOG_DIR}/01_config.log
			exec 2>> ${CLFS_PAK_LOG_DIR}/01_config.error.log
			f_log WHITE "CONFIG: ${_file}"
			eval "$(minor_pars_script_clfs ${_script} 'CONFIG')" | f_log NC || ERR_FLAG=${?}
		fi

		if [ ${ERR_FLAG} -eq 0 ]; then
			exec >> ${CLFS_PAK_LOG_DIR}/02_build.log
			exec 2>> ${CLFS_PAK_LOG_DIR}/02_build.error.log
			f_log WHITE "BUILD: ${_file}"
			eval "$(minor_pars_script_clfs ${_script} 'BUILD')" | f_log NC || ERR_FLAG=${?}
		fi

		if [ ${ERR_FLAG} -eq 0 ]; then
			exec >> ${CLFS_PAK_LOG_DIR}/03_install.log
			exec 2>> ${CLFS_PAK_LOG_DIR}/03_install.error.log
			f_log WHITE "INSTALL: ${_file}"
			eval "$(minor_pars_script_clfs ${_script} 'INSTALL')" | f_log NC || ERR_FLAG=${?}
		fi
		popd
	else
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
	exec 1>&6 2>&7 0<&8
	exec 6>&- 7>&- 8<&-
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
				[ -d ${BUILD_DIR} ] && rm -Rf ${BUILD_DIR}/*
				local _flag=''
				continue 2
			;;
			'c')
				ERR_FLAG=0
				local _flag=''
			;;
			'x')	return ${ERR_FLAG} ;;
		esac
	done
	break
done
}

################################################################################
