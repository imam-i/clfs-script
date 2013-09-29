#!/bin/bash
################################################################################
# Функция "_tools_clfs"
# Version: 0.1

_tools_clfs ()
{
cd ${CLFS_PWD}
for _functions in ${CLFS_PWD}/_functions/*.sh
do
	. ${_functions}
done

local CLFS_FLAG='_tools-clfs'

local TOOLS_CLFS_FLAG=${1}
local SYSTEM_CLFS_FLAG=${2}
local BLFS_FLAG=${3}
local CHROOT_FLAG=${4}

# Перехватываем ошибки.
local restoretrap

set -eE

restoretrap=`trap -p ERR`
trap '_ERROR' ERR
eval $restoretrap

# Удаляем запуск скрипта.
sed -e "/\/_su\/_ctools.sh/d" \
    -e '/^exit/d' \
    -i ~/.bashrc

# Назначение переменных (массивов) хроняших информацию о пакетах.
array_packages

# Каталог для хронения лог-файлов tools
_LOG="${CLFS_LOG}/ctools"
install -d ${_LOG}

case ${TOOLS_CLFS_FLAG} in
	3)	# 11
		scripts_ctools '04.Final Preparations'	#-1
		scripts_ctools 'pm.Pacman'	#1-
		;;
	2)	# 10
		scripts_ctools 'pm.Pacman' '04.Final Preparations'	#1-
		;;
	1)	# -1
		scripts_ctools '04.Final Preparations'		#-1
		scripts_ctools '05.Constructing Cross-Compile Tools'
		;;
	0)	# 00
		if [ "${CHROOT_FLAG}" -gt 0 ] || \
		   [ "${SYSTEM_CLFS_FLAG}" -gt 0 ] || \
		   [ "${BLFS_FLAG}" -gt 0 ]; then
			untar_clfs 'pm.Pacman' '04.Final Preparations'	#1-
		else
			return 0
		fi
		;;
	*) echo 'Не верный параметер константы "TOOLS_CLFS_FLAG"' ;;
esac

set +Ee
}

_tools_clfs $*

################################################################################
