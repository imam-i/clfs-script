#!/bin/bash
################################################################################
# Функция "pack-var"
# Version: 0.1

minor_pack_var ()
{
#local php_conf_dir="${CLFS_PWD}/${PREFIX}/packages.conf.php"

local BOOK=`echo ${1} | cut -d. -f1`
local CHAPTER=`echo ${1} | cut -d. -f2`
local NAME=`echo ${1} | cut -d. -f3`

#${CLFS_PWD}/_functions/php/pack_var.php ${php_conf_dir} ${1}
${CLFS_PWD}/_functions/perl/pack_var.pl -p ${CLFS_CONF} -b ${BOOK} -c ${CHAPTER} -n ${NAME}
}

################################################################################
