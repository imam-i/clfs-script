#!/bin/bash
################################################################################
# Функция "array-packages"
# Version: 0.1

array_packages ()
{

unset clfs blfs pm clfs_var_arr blfs_var_arr pm_var_arr my_var_arr

_array_packages () {
	unset array
	source "${1}" || return ${?}
	for (( i=0; i < ${#array[@]}; i++ ))
	do
		clfs_var_arr[${#clfs_var_arr[@]}]="${array[${i}]}"
	done
}

if [ -d ${CLFS_PWD}/${PREFIX}/packages.conf ]; then
	for _conf in ${CLFS_PWD}/${PREFIX}/packages.conf/*.conf
	do
		_array_packages "${_conf}"
	done
else
	_array_packages "${CLFS_PWD}/${PREFIX}/packages.conf"
fi

unset array

}

################################################################################
