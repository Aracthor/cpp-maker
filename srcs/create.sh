#!/bin/bash
## create.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Jul 27 16:31:58 2015 Aracthor
## Last Update Tue Jul 28 17:35:04 2015 Aracthor
##

CREATE_USAGE="\
USAGE:\n\
  $0 $1 <object name> [<destination folder>]\n\
  $0 $1 <object name> <include folder> <srcs folder>\
"

INCLUDES=()
MEMBERS_TYPES=()
MEMBERS_NAMES=()
METHODS=()
NATIVES=("char" "int" "long" "float" "double")

CLASS_NAME=""
CLASS=$TRUE
ABSTRACT=$TRUE
MOTHER=""
DEFAULT_CONSTRUCTOR=$TRUE
COPY_CONSTRUCTOR=$TRUE

list_includes ()
{
    INCLUDES+=($MOTHER)
}

create_header ()
{
    list_includes

    # Includes
    local included=()
    local data=""
    for include in ${INCLUDES[*]}
    do
	namespace=$(get_namespace $include)
	class=$(get_class $include)
	if [ $(array_contains NATIVES $include) == $FALSE ] && [ $(array_contains included $include) == $FALSE ]
	then
	    included+=($include)
	    if [ "$namespace" == "std" ]
	    then
		include="<$class>"
	    elif [ "$namespace" != "" ]
	    then
		include="\"$namespace/$class.hh\""
	    else
		include="\"$class.hh\""
	    fi
	    data=$data"#include $include\n"
	fi
    done

    # Class name
    data=$data"\nclass\t$CLASS_NAME"
    if [ "$MOTHER" != "" ]
    then
	data=$data" : public $MOTHER"
    fi
    data=$data"\n{\npublic:\n"

    # Constructors
    if [ $CLASS == $TRUE ]
    then
	if [ $DEFAULT_CONSTRUCTOR == $TRUE ]
	then
	    data=$data"    $CLASS_NAME();\n"
	fi
	if [ $COPY_CONSTRUCTOR == $TRUE ]
	then
	    data=$data"    $CLASS_NAME(const $CLASS_NAME& ref);\n"
	fi
    fi

    # Detructor
    line="    "
    if [ $CLASS == $FALSE ] || [ $ABSTRACT == $TRUE ]
    then
	line=$line"virtual "
    fi
    line=$line"~$CLASS_NAME()"
    if [ $CLASS == $TRUE ]
    then
	line=$line";"
    else
	line=$line" {}"
    fi
    data=$data"$line\n"

    # Members
    if [ ${#MEMBERS[@]} > 0 ]
    then
	if [ $ABSTRACT == $TRUE ]
	then
	    data=$data"\nprotected:\n"
	else
	    data=$data"\nprivate:\n"
	fi

	for (( i=0; i < ${#MEMBERS_TYPES[@]}; ++i ))
	do
	    type=${MEMBERS_TYPES[$i]}
	    name=${MEMBERS_NAMES[$i]}
	    data=$data"    $type\tm_$name;\n"
	done
    fi

    # Closure
    data=$data"};"

    echo -e "$data" > $1
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

	if [ $CLASS == $TRUE ]
	then
	    DEFAULT_CONSTRUCTOR=$(read_boolean "Default constructor ?" 'y' 'n')
	    COPY_CONSTRUCTOR=$(read_boolean "Copy constructor ?" 'y' 'n')

	    echo "Members: " >&2
	    while true
	    do
		type=$(read_string "Type: ")
		if [ "$type" == "" ]
		then
		    break
		fi
		name=$(read_string "Name: ")
		MEMBERS_TYPES+=("$type")
		MEMBERS_NAMES+=("$name")
		INCLUDES+=("$type")
	    done
	fi

	create_header $header_file
    fi
    return 0
}
