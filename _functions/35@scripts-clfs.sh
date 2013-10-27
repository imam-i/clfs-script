#!/bin/bash
################################################################################
# Функция "scripts_clfs"
# Version: 0.1

scripts_clfs ()
{
local _ID=${1:0:2}
local _archive="${_ID}_${CLFS_ARCH}_clfs.tar.bz2"

# clear
rm -Rf ${_LOG}/${_ID} ${CLFS_SRC}/${_archive}
install -dv ${_LOG}/${_ID}

color-echo 'scripts-clfs.sh' ${MAGENTA}
color-echo "1 : ${1}" ${MAGENTA}
color-echo "2 : ${2}" ${MAGENTA}
color-echo "3 : ${3}" ${MAGENTA}

# Проверка зависимостей
if [ -n "${2}" ]; then
	untar_clfs "${2}"
#	[ ${ERR_FLAG} -gt 0 ] && return ${ERR_FLAG}
fi

echo "scripts_build: ${1}" >> "${_LOG}/${_ID}/${_ID}_clfs.log"
date >> "${_LOG}/${_ID}/${_ID}_clfs.log"
echo '+++++++++++++++++env+++++++++++++++++++' >> "${_LOG}/${_ID}/${_ID}_clfs.log"
env >> "${_LOG}/${_ID}/${_ID}_clfs.log"
echo '+++++++++++++++++++++++++++++++++++++++' >> "${_LOG}/${_ID}/${_ID}_clfs.log"
echo '++++++++++++++++local++++++++++++++++++' >> "${_LOG}/${_ID}/${_ID}_clfs.log"
local >> "${_LOG}/${_ID}/${_ID}_clfs.log"
echo '+++++++++++++++++++++++++++++++++++++++' >> "${_LOG}/${_ID}/${_ID}_clfs.log"

unset _pack_var

local _script
for _script in ${CLFS_PWD}/${PREFIX}/`basename ${_LOG}`/${_ID}_*/${_ID}.[0-9][0-9]_*
do
	local _file=`basename "${_script}"`
	local _NAME=`echo ${_file} | cut -d_ -f2 | cut -d. -f1`

	if [[ -f ${_script} ]]; then
		local _log="${_LOG}/${_ID}/${_file}.log"
	else
		local _log="${_LOG}/${_ID}/${_file}_dir.log"
		# Отключена ссборка пакетов pacman.
		continue
	fi
	[[ -f ${_log} ]] && rm -vf ${_log}
	local logpipe=$(mktemp -u "${_LOG}/${_ID}/logpipe.XXXXXXXX")
	mkfifo "${logpipe}"
	tee "${_log}" < "${logpipe}" &
	local teepid=${!}

	# Назначаем переменные пакета
	_pack_var=`pack_var "clfs.${_ID}.${_NAME}"`
	local ${_pack_var}
	local name="${_NAME}"

	while [ true ]
	do
		echo "${_ID}    ${name}    ${_file}"
		if [ -f ${_script} ]; then
			. ${_script} || ERR_FLAG=${?}
		else
			date
			local _url=$(echo ${url} | sed -e "s/_version/${version}/g")

			# Проверка на наличие патчей
			for (( n=1; n <= 9; n++ ))
			do
				local urlpatch="urlpatch${n}"
				if [ "${!urlpatch}" ]; then
					_url="${_url}"$'\n'$(echo ${!urlpatch} | sed -e "s/_version/${version}/g")
					local md5patch="md5patch${n}"
					md5="${md5}"$'\n'${!md5patch}
				fi
			done

			export name version _url md5
			pushd ${_script}
				makepkg_clfs ${_file} || ERR_FLAG=${?}
				pacman_clfs ${_file} || ERR_FLAG=${?}
			popd
			unset name version _url md5
		fi
		local _flag=''
		while [ ${ERR_FLAG} -ne 0 ] && [ "${_flag}" = '' ]
		do
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
				'x')      return ${ERR_FLAG} ;;
#				*)	return ${ERR_FLAG} ;;
			esac
		done
		break
	done &>"${logpipe}"

	[ ${ERR_FLAG} -ne 0 ] && break
	[ -d ${BUILD_DIR} ] && rm -Rf ${BUILD_DIR}/*

	wait ${teepid}
	rm "${logpipe}"

	clear_per "${_pack_var}"

	date >> ${_log}
done

if [ ${ERR_FLAG} -eq 0 ]; then
	color-echo "OK: ${1}" ${GREEN}
else
	color-echo "ERROR: ${1}" ${RED}
	return ${ERR_FLAG}
fi

if [ "${_ID}" = '04' ]; then
	pushd ${CLFS_CROSS_TOOLS}
		color-echo "Создание переменной: \"${_ID}-cross-tools\"" ${GREEN}
		local _files=`find ./ | sed -e '1d'`
		color-echo "Создание архива: \"${_archive}\"" ${GREEN}
		[ -f ${CLFS_OUT}/${_archive} ] && rm -f ${CLFS_OUT}/${_archive}
		tar -cjf ${CLFS_OUT}/${_archive} ${_files}

		color-echo "Проверка архива: \"${_archive}\"" ${GREEN}
		bzip2 -t ${CLFS_OUT}/${_archive}
	popd
fi

date >> "${_LOG}/${_ID}/${_ID}_clfs.log"
}

################################################################################
