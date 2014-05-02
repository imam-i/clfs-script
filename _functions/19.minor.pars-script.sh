#!/bin/bash
################################################################################
# Функция "minor_pars_script_clfs"
# Version: 0.1

minor_pars_script_clfs ()
{

sed -e "/^%${2}%/,/^%/p" \
    -n ${1} | \
sed -e ':a;N;$!ba;s/\\\n//g' | \
sed -e '/^%\|^$\|^#/d' \
    -e 's/ \{1,\}/ /g' \
    -e 's/\t\{1,\}/ /g'
}

################################################################################