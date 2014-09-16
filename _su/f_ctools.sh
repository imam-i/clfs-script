#!/bin/bash
################################################################################
# Функция "su_tools"
# Version: 0.1

f_su_tools ()
{
cd ${CLFS_PWD}
for _functions in ${CLFS_PWD}/_functions/*.sh
do
	. ${_functions}
done

local CLFS_FLAG='su_tools'

#local TOOLS_FLAG=${1}
#local SYSTEM_FLAG=${2}
#local BLFS_FLAG=${3}
#local SU_FLAG=${4}

# Перехватываем ошибки.
trap _ERROR ERR
set -eo pipefail

# Удаляем запуск скрипта.
sed -e "/\/_su\/f_ctools.sh/d" \
    -e '/^exit/d' \
    -i ~/.bashrc

# Каталог для хронения лог-файлов tools
CLFS_MAIN_LOG_DIR="${CLFS_LOG}/tools"
install -d ${CLFS_MAIN_LOG_DIR}

minor_scripts 'lfs.05.Constructing a Temporary System'

## 6.2. Build Variables
#export CC="${CLFS_TARGET}-gcc"
#export CXX="${CLFS_TARGET}-g++"
#export AR="${CLFS_TARGET}-ar"
#export AS="${CLFS_TARGET}-as"
#export RANLIB="${CLFS_TARGET}-ranlib"
#export LD="${CLFS_TARGET}-ld"
#export STRIP="${CLFS_TARGET}-strip"

#echo export CC=\""${CC}\"" >> ~/.bashrc
#echo export CXX=\""${CXX}\"" >> ~/.bashrc
#echo export AR=\""${AR}\"" >> ~/.bashrc
#echo export AS=\""${AS}\"" >> ~/.bashrc
#echo export RANLIB=\""${RANLIB}\"" >> ~/.bashrc
#echo export LD=\""${LD}\"" >> ~/.bashrc
#echo export STRIP=\""${STRIP}\"" >> ~/.bashrc

#f_scripts_clfs '06.Constructing a Temporary System' 05

set +e
}

f_su_tools

################################################################################
