#!/bin/bash
################################################################################
# Функция "log"
# Version: 0.1

function f_log {
#exec 6>&1 7>&2 8<&0
#exec >> ${_log}.log
#exec 2>> ${_log}.error.log

local CLFS_FLAG='f_log'

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
		case "${color}" in
			red | RED | green | GREEN | yellow | YELLOW | blue | BLUE | magenta | MAGENTA | cyan | CYAN | white | WHITE)
				printf "\r${!color}%s${NC}\n" "${@}" >&6
			;;
		esac
		printf "\r[%02d:%02d] %s" $((SECONDS/60)) $((SECONDS%60)) "${_prog_bar[$((_prog_bar_cpt/10))]}" >&6
		_prog_bar_cpt=$(((_prog_bar_cpt+1)%40))
	done )

#exec 1>&6 2>&7 0<&8
#exec 6>&- 7>&- 8<&-
}

################################################################################
