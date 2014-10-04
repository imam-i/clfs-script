#!/bin/bash
################################################################################
# Функция "su_tools"
# Version: 0.1

su_tools ()
{
cd ${CLFS_PWD}

# Определяем переменные.
source ${CLFS_PWD}/conf/config.sh

# Определяем функции.
for _functions in ${CLFS_PWD}/_functions/*.sh
do
	. ${_functions}
done

# Перехватываем ошибки.
trap _ERROR ERR
set -Eo pipefail

# Удаляем запуск скрипта.
sed -e "/\/_su\/_ctools.sh/d" \
    -e '/^exit/d' \
    -i ~/.bashrc

# Каталог для хронения лог-файлов tools
local CLFS_MAIN_LOG_DIR="${CLFS_LOG}/tools"
local CLFS_MAIN_LOG_FILE="${CLFS_LOG}/tools.log"
install -d ${CLFS_MAIN_LOG_DIR}

minor_exec_io OK
exec >> ${CLFS_MAIN_LOG_FILE} 2>> ${CLFS_MAIN_LOG_FILE}

minor_scripts 'nolfs.pm.PacMan' 'lfs.05.Tools'

exec >> ${CLFS_MAIN_LOG_FILE} 2>> ${CLFS_MAIN_LOG_FILE}

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

echo $ERR_FLAG > ${CLFS_LOG}/tools.flag

minor_exec_io OFF

set +E
}

su_tools

################################################################################
