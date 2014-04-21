#!/bin/bash
################################################################################
# Функция "pack-var"
# Version: 0.1

f_pack_var ()
{
local php_conf_dir="${CLFS_PWD}/${PREFIX}/packages.conf.php"

${CLFS_PWD}/_functions/php/pack_var.php ${php_conf_dir} ${1}
}

################################################################################
