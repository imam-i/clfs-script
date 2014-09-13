#!/bin/bash
################################################################################
# Функция "log"
# Version: 0.1

function f_log {
#exec 6>&1 7>&2 8<&0
#exec >> ${_log}.log
#exec 2>> ${_log}.error.log

local CLFS_FLAG='f_log'

local CT_LOG_PROGRESS_BAR=y
local ERROR="${RED}"
local WARN="${YELLOW}"
local INFO="${WHITE}"
local EXTRA="${WHITE}"
local CFG="${NC}"
local FILE="${NC}"
local STATE="${NC}"
local ALL="${NC}"
local DEBUG="${WHITE}"

#local color="${1}"; shift
local max_level LEVEL level cur_l cur_L

local CT_LOG_LEVEL_MAX='EXTRA'
eval max_level="\${CT_LOG_LEVEL_${CT_LOG_LEVEL_MAX}}"
[ -z "${max_level}" ] && max_level=${CT_LOG_LEVEL_DEBUG}

LEVEL="$1"; shift
eval level="\${CT_LOG_LEVEL_${LEVEL}}"

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
		case "${CT_LOG_SEE_TOOLS_WARN},${line}" in
			y,*"warning:"*)		cur_L=WARN; cur_l=${CT_LOG_LEVEL_WARN};;
			y,*"WARNING:"*)		cur_L=WARN; cur_l=${CT_LOG_LEVEL_WARN};;
			*"error:"*)		cur_L=ERROR; cur_l=${CT_LOG_LEVEL_ERROR};;
			*"make["*"]: *** ["*)	cur_L=ERROR; cur_l=${CT_LOG_LEVEL_ERROR};;
			*)			cur_L="${LEVEL}"; cur_l="${level}";;
		esac
		printf "%s%s[%-5s]%s%s\n" "$(date +%Y-%m-%d\ %H:%M:%S)" "   " "${cur_L}" "   " "${line}"
#		printf "%s\n" "${line}"
		if [ ${cur_l} -le ${max_level} ]; then
			printf "${!cur_L}${CT_LOG_PROGRESS_BAR:+\r}[%-5s]%s%s${NC}\n" "${cur_L}" " " "${line}" >&6
#			printf "\r${!color}%s${NC}\n" "${@}" >&6
		fi
		if [ "${CT_LOG_PROGRESS_BAR}" = "y" ]; then
			printf "\r[%02d:%02d] %s" $((SECONDS/60)) $((SECONDS%60)) "${_prog_bar[$((_prog_bar_cpt/10))]}" >&6
			_prog_bar_cpt=$(((_prog_bar_cpt+1)%40))
		fi
	done )

#exec 1>&6 2>&7 0<&8
#exec 6>&- 7>&- 8<&-
}

################################################################################
