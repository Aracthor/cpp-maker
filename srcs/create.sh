#!/bin/bash
## create.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## Login   <aracthor@epitech.net>
## 
## Started on  Mon Jul 27 16:31:58 2015 Aracthor
## Last Update Mon Jul 27 17:34:50 2015 Aracthor
##

CREATE_USAGE="\
USAGE:\n\
  $0 $1 <object name> [<destination folder>]\n\
  $0 $1 <object name> <include folder> <srcs folder>\
"

function create
{
    if [ $# -lt 2 ] || [ $# -gt 4 ]
    then
	echo -e $CREATE_USAGE >&2
	return 2
    else

	# Arguments gathering
	class_name=$2
	if [ $# -eq 2 ]
	then
	    include_dir="./"
	    source_dir="./"
	elif [ $# -eq 3 ]
	then
	    include_dir=$3
	    source_dir=$3
	else
	    include_dir=$3
	    source_dir=$4
	fi

	# TODO
    fi
    return 0
}
