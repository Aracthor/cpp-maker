#!/bin/bash
## create.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Jul 27 16:31:58 2015 Aracthor
## Last Update Tue Jul 28 14:34:13 2015 Aracthor
##

CREATE_USAGE="\
USAGE:\n\
  $0 $1 <object name> [<destination folder>]\n\
  $0 $1 <object name> <include folder> <srcs folder>\
"

INCLUDES=()
CLASS_NAME=""
CLASS=$TRUE
ABSTRACT=$TRUE
MOTHER=""

STL=("deque", "list", "map", "queue", "stack", "vector")

list_includes ()
{
    INCLUDES+=($MOTHER)
}

create_header ()
{
    list_includes

    local data=""
    for include in ${INCLUDES[*]};
    do
	stl_include=$(array_contains STL $include)
	if [ $stl_include == $TRUE ]
	then
	    include="<$include>"
	else
	    include="\"$include.hh\""
	fi
	data=$data"#include $include\n"
    done

    data=$data"\nclass\t$2"
    if [ "$mother" != "" ]
    then
	data=$data" : public $mother"
    fi

    echo -e $data > $1
}

create ()
{
    if [ $# -lt 2 ] || [ $# -gt 4 ]
    then
	echo -e $CREATE_USAGE >&2
	return 2
    else

	# Arguments gathering
	CLASS_NAME=$2
	if [ $# -eq 2 ]
	then
	    include_dir="./"
	    source_dir="./"
	elif [ $# -eq 3 ]
	then
	    include_dir="$3/"
	    source_dir="$3/"
	else
	    include_dir="$3/"
	    source_dir="$4/"
	fi

	source_file="$source_dir$CLASS_NAME.cpp"
	header_file="$include_dir$CLASS_NAME.hh"
	template_file="$include_dir$CLASS_NAME.hpp"

	CLASS=$(read_boolean "Class or Interface ?" 'c' 'i')
	if [ $CLASS == $TRUE ]
	then
	    ABSTRACT=$(read_boolean "Inheritable ?" 'y' 'n')
	fi
	MOTHER=$(read_string "Inherit from: ")

	create_header $header_file
    fi
    return 0
}
