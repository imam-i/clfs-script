#!/bin/bash
################################################################################
# Функция "log"
# Version: 0.1

function f_log {
local color="${1}"; shift
if [ "$#" -eq 0 ]
then	cat -
else	printf "%s\n" "${*}"
fi |  ( IFS=`printf "\n"`
	_prog_bar_cpt=0
	_prog_bar[0]='/'
	_prog_bar[1]='-'
	_prog_bar[2]='\'
	_prog_bar[3]='|'
	while read line
	do
		printf "%s\n" "${line}"
		if [ "${color}" != 'NC' ]; then
			printf "\r${!color}%s${NC}\n" "${@}" >&6
		fi
		printf "\r[%02d:%02d] %s" $((SECONDS/60)) $((SECONDS%60)) "${_prog_bar[$((_prog_bar_cpt/10))]}" >&6
		_prog_bar_cpt=$(((_prog_bar_cpt+1)%40))
	done )
}

################################################################################
