#!/bin/bash
################################################################################
# Функция "_tools_clfs"
# Version: 0.1

_f_tools_clfs ()
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
local SU_FLAG=${4}

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

# Каталог для хронения лог-файлов tools
LOG_DIR="${CLFS_LOG}/tools_clfs"
install -d ${LOG_DIR}

f_scripts_clfs '05.Constructing Cross-Compile Tools'

# 6.2. Build Variables
export CC="${CLFS_TARGET}-gcc"
export CXX="${CLFS_TARGET}-g++"
export AR="${CLFS_TARGET}-ar"
export AS="${CLFS_TARGET}-as"
export RANLIB="${CLFS_TARGET}-ranlib"
export LD="${CLFS_TARGET}-ld"
export STRIP="${CLFS_TARGET}-strip"

echo export CC=\""${CC}\"" >> ~/.bashrc
echo export CXX=\""${CXX}\"" >> ~/.bashrc
echo export AR=\""${AR}\"" >> ~/.bashrc
echo export AS=\""${AS}\"" >> ~/.bashrc
echo export RANLIB=\""${RANLIB}\"" >> ~/.bashrc
echo export LD=\""${LD}\"" >> ~/.bashrc
echo export STRIP=\""${STRIP}\"" >> ~/.bashrc

f_scripts_clfs '06.Constructing a Temporary System'

set +Ee
}

_f_tools_clfs $*

################################################################################
