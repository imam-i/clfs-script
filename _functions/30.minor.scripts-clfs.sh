#!/bin/bash
################################################################################
# Функция "scripts_clfs"
# Version: 0.1

f_scripts_clfs ()
{
local message="${1}"; shift
local ID=${message:0:2}
local _archive="${ID}_${CLFS_ARCH}_clfs.tar.bz2"
local CLFS_MINOR_LOG_DIR="${CLFS_MAIN_LOG_DIR}/${ID}"
local CLFS_MINOR_LOG_FILE="${CLFS_MINOR_LOG_DIR}/${ID}_clfs.log"
#local LOG_FILE="${CLFS_MINOR_LOG_DIR}/${ID}_clfs.log"

install -dv ${CLFS_MINOR_LOG_DIR}
rm -f ${CLFS_MINOR_LOG_FILE}

minor_exec_io_clfs OK
exec >> ${CLFS_MINOR_LOG_FILE} 2>> ${CLFS_MINOR_LOG_FILE}

f_log INFO 'scripts-clfs.sh'
#color-echo 'scripts-clfs.sh' ${MAGENTA}

if [ -f ${CLFS_OUT}/${_archive} ] && [ $(cat ${CLFS_MINOR_LOG_DIR}/${ID}_flag) -eq 0 ]; then

	f_untar "${message}"

	if [ ${ERR_FLAG} -eq 0 ]; then
#		color-echo "OK: ${message}" ${GREEN}
		f_log INFO "OK: ${message}"
	else
		f_log ERROR "ERROR: ${message}"
#		color-echo "ERROR: ${message}" ${RED}
	fi
	return ${ERR_FLAG}
fi

# clear
rm -f ${CLFS_SRC}/${_archive}
#rm -Rf ${CLFS_MINOR_LOG_DIR} ${CLFS_SRC}/${_archive}
#install -dv ${CLFS_MINOR_LOG_DIR}

echo "f_scripts_build: ${message}"
date
echo '+++++++++++++++++env+++++++++++++++++++'
env
echo '+++++++++++++++++++++++++++++++++++++++'
echo '++++++++++++++++local++++++++++++++++++'
local
echo '+++++++++++++++++++++++++++++++++++++++'

unset _pack_var

local _script
for _script in ${CLFS_PWD}/${PREFIX}/`basename ${CLFS_MAIN_LOG_DIR}`/${ID}_*/${ID}.[0-9][0-9]_*
do
	local _file=`basename "${_script}"`
	local _NAME=`echo ${_file} | cut -d_ -f2 | cut -d. -f1`

	if [ -f ${_script} ]; then
		local CLFS_PAK_LOG_DIR="${CLFS_MINOR_LOG_DIR}/${_file}"
	else
		local CLFS_PAK_LOG_DIR="${CLFS_MINOR_LOG_DIR}/${_file}_dir"
		# Отключена ссборка пакетов pacman.
		continue
	fi
	rm -rf ${CLFS_PAK_LOG_DIR}
#	install -d ${CLFS_PAK_LOG_DIR}

	# Назначаем переменные пакета
	local _pack_var=`f_pack_var "lfs.${ID}.${_NAME}"`

#	minor_exec_io_clfs OK
	f_build_clfs
#	minor_exec_io_clfs OFF

	[ ${ERR_FLAG} -ne 0 ] && break
	[ -d ${BUILD_DIR} ] && rm -Rf ${BUILD_DIR}/*
done

echo ${ERR_FLAG} > ${CLFS_MINOR_LOG_DIR}/${ID}_flag

if [ ${ERR_FLAG} -eq 0 ]; then
	f_log INFO "OK: ${message}"
#	color-echo "OK: ${message}" ${GREEN}
else
#	color-echo "ERROR: ${message}" ${RED}
	f_log ERROR "ERROR: ${message}"
	return ${ERR_FLAG}
fi

# Создание файла: "XX-files"
minor_file_clfs ${*}

f_log INFO "Создание архива: \"${_archive}\""
#color-echo "Создание архива: \"${_archive}\"" ${GREEN}
[ -f ${CLFS_OUT}/${_archive} ] && rm -f ${CLFS_OUT}/${_archive}
tar -cjvf ${CLFS_OUT}/${_archive} -T ${CLFS_MINOR_LOG_DIR}/${ID}-files 2>&1 | f_log EXTRA

f_log INFO "Проверка архива: \"${_archive}\""
#color-echo "Проверка архива: \"${_archive}\"" ${GREEN}
bzip2 -t ${CLFS_OUT}/${_archive} 2>&1 | f_log EXTRA

date
}

################################################################################
