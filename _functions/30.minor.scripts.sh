#!/bin/bash
################################################################################
# Функция "scripts"
# Version: 0.1

minor_scripts ()
{
local CLFS_FLAG="${FUNCNAME}"

local message="${1}"; shift
local BOOK=`echo ${message} | cut -d. -f1`
local ID=`echo ${message} | cut -d. -f2`
local _archive="${ID}_${CLFS_ARCH}_clfs.tar.bz2"
local CLFS_MINOR_LOG_DIR="${CLFS_MAIN_LOG_DIR}/${ID}"
local CLFS_MINOR_LOG_FILE="${CLFS_MAIN_LOG_DIR}/${ID}.log"
local _flag=''

# Проверка зависимостей
if [ -n "${1}" ]; then
	minor_scripts "${1}"
fi

rm -rf ${CLFS_MINOR_LOG_FILE} ${CLFS_MINOR_LOG_DIR}
exec >> ${CLFS_MINOR_LOG_FILE} 2>> ${CLFS_MINOR_LOG_FILE}

install -dv ${CLFS_MINOR_LOG_DIR}

minor_log INFO "${FUNCNAME}: ${message}"

if [ -f ${CLFS_OUT}/${_archive} ] && [ $(cat ${CLFS_MAIN_LOG_DIR}/${ID}.flag) -eq 0 ]; then

	minor_untar "${message}"

	if [ ${ERR_FLAG} -eq 0 ]; then
		minor_log INFO "OK: ${message}"
	else
		minor_log ERROR "ERROR: ${message}"
	fi
	return ${ERR_FLAG}
fi

# clear
rm -f ${CLFS_SRC}/${_archive}

echo "${FUNCNAME}: ${message}"
date
echo '+++++++++++++++++env+++++++++++++++++++'
env
echo '+++++++++++++++++++++++++++++++++++++++'
echo '++++++++++++++++local++++++++++++++++++'
local
echo '+++++++++++++++++++++++++++++++++++++++'

unset pkg_var

local pkg_dir=${CLFS_PWD}/${PREFIX}/`basename ${CLFS_MAIN_LOG_DIR}`/${ID}_*
local pkg
#for pkg in ${CLFS_PWD}/${PREFIX}/`basename ${CLFS_MAIN_LOG_DIR}`/${ID}_*/${ID}.[0-9][0-9]_*
for pkg in `minor_pack_var ${BOOK}.${ID}.all | cut -d. -f2-`
do
	local NAME=`echo ${pkg} | cut -d. -f3`
	local pkg_file=${NAME}.${BOOK}

	minor_build
	exec >> ${CLFS_MINOR_LOG_FILE} 2>> ${CLFS_MINOR_LOG_FILE}

	while [ ${ERR_FLAG} -ne 0 ] && [ "${_flag}" = '' ]
	do
		minor_log DEBUG "Ошибка ${pkg}: ${_file}"
		minor_log DEBUG "Повторить - r"
		minor_log DEBUG "Пропустить - c"
		minor_log DEBUG "Остановить - x"
		printf "\r\t\r" >&6
		read _flag
		case ${_flag} in
			'r')
				ERR_FLAG=0
				[ -d ${BUILD_DIR} ] && rm -Rf ${BUILD_DIR}/*
				local _flag=''
				minor_build
				exec >> ${CLFS_MINOR_LOG_FILE} 2>> ${CLFS_MINOR_LOG_FILE}
			;;
			'c')
				ERR_FLAG=0
				local _flag=''
				continue 2
			;;
			'x')
				break 2
			;;
		esac
	done

	exec >> ${CLFS_MINOR_LOG_FILE} 2>> ${CLFS_MINOR_LOG_FILE}

	[ -d ${BUILD_DIR} ] && rm -Rf ${BUILD_DIR}/*
done

exec >> ${CLFS_MINOR_LOG_FILE} 2>> ${CLFS_MINOR_LOG_FILE}

minor_log INFO '======================================================'

echo ${ERR_FLAG} > ${CLFS_MAIN_LOG_DIR}/${ID}.flag

if [ ${ERR_FLAG} -eq 0 ]; then
	minor_log INFO "OK: ${message}"
else
	minor_log ERROR "ERROR: ${message}"
	return ${ERR_FLAG}
fi

# Создание файла: "XX-files"
minor_file ${*}

minor_log INFO "Создание архива: \"${_archive}\""
[ -f ${CLFS_OUT}/${_archive} ] && rm -f ${CLFS_OUT}/${_archive}
tar -cjvf ${CLFS_OUT}/${_archive} -T ${CLFS_MINOR_LOG_DIR}/files 2>&1 | minor_log ALL

minor_log INFO "Проверка архива: \"${_archive}\""
bzip2 -vt ${CLFS_OUT}/${_archive} 2>&1 | minor_log ALL

date
#minor_exec_io OFF
}

################################################################################
