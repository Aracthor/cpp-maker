#!/bin/bash
## create.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Jul 27 16:31:58 2015 Aracthor
## Last Update Wed Jul 29 17:25:41 2015 Aracthor
##

CREATE_USAGE="\
USAGE:\n\
  $0 $1 <object name> [<destination folder>]\n\
  $0 $1 <object name> <include folder> <srcs folder>\
"

MEMBERS_TYPES=()
MEMBERS_NAMES=()
MEMBERS_GETTERS=()

INCLUDES=()
METHODS=()
NATIVES=("char" "short" "int" "long" "float" "double")
GETTERS=()

MACCRO=""
CLASS_NAME=""
CLASS=$TRUE
ABSTRACT=$TRUE
MOTHER=""
DEFAULT_CONSTRUCTOR=$TRUE
COPY_CONSTRUCTOR=$TRUE

list_includes ()
{
    INCLUDES+=($MOTHER)
    local new_includes=()
    local included=()

    for include in ${INCLUDES[*]}
    do
	include=$(read_type $include)
	namespace=$(get_namespace $include)
	class=$(get_class $include)
	if [ "$include" != "const" ] && [ $(array_contains NATIVES $include) == $FALSE ] && [ $(array_contains included $include) == $FALSE ]
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
	    new_includes+=($include)
	fi
    done

    INCLUDES=()
    for include in ${new_includes[*]}
    do
	INCLUDES+=($include)
    done
}

list_getters ()
{
    for (( i=0; i < ${#MEMBERS_TYPES[@]}; ++i ))
    do
	getter=${MEMBERS_GETTERS[$i]}
	if [ $getter == $TRUE ]
	then
	    name=${MEMBERS_NAMES[$i]}
	    type=${MEMBERS_TYPES[$i]}
	    pure_type=$(read_type $type)
	    if [ $(array_contains NATIVES $pure_type) == $FALSE ] && [ "$type" == "$pure_type" ]
	    then
		type=$type"&"
	    fi
	    if [ $(type_is_const $type) == $FALSE ] && [ $(array_contains NATIVES $pure_type) == $FALSE ]
	    then
		type="const "$type
	    fi
	    method="get""${name^}"
	    prototype=$(echo "inline ""$type\t$method""() const;" | sed "s/ /_/g")
	    GETTERS+=($prototype)
	fi
    done
}

create_header ()
{
    local data=""

    # Double-inclusion protection
    data=$data"#ifndef $MACCRO\n"
    data=$data"# define $MACCRO\n"

    # Includes
    list_includes
    if (( ${#INCLUDES[@]} > 0 ))
    then
	data=$data"\n"
    fi
    for include in ${INCLUDES[@]}
    do
	data=$data"# include $include\n"
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

    # Getters
    list_getters
    if (( ${#GETTERS[@]} > 0 ))
    then
	data=$data"\npublic:\n"
	for getter in ${GETTERS[*]}
	do
	    getter=$(echo "   " $getter | sed "s/_/ /g")
	    data=$data$getter"\n"
	done
    fi

    # Members
    if (( ${#MEMBERS_TYPES[@]} > 0 ))
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
    data=$data"};\n\n"
    if (( ${#GETTERS[@]} > 0 ))
    then
	data=$data"# include \"$CLASS_NAME.hpp\"\n\n"
    fi
    data=$data"#endif // !$MACCRO"

    echo -e "$data" > $1
}

create_inline ()
{
    local data=""

    for (( i=0; i < ${#MEMBERS_TYPES[@]}; ++i ))
    do
	getter=${MEMBERS_GETTERS[$i]}
	if [ $getter == $TRUE ]
	then
	    name=${MEMBERS_NAMES[$i]}
	    type=${MEMBERS_TYPES[$i]}
	    pure_type=$(read_type $type)
	    if [ $(array_contains NATIVES $pure_type) == $FALSE ] && [ "$type" == "$pure_type" ]
	    then
		type=$type"&"
	    fi
	    if [ $(type_is_const $type) == $FALSE ] && [ $(array_contains NATIVES $pure_type) == $FALSE ]
	    then
		type="const "$type
	    fi

	    method="get""${name^}"
	    data=$data"\n$type\n"
	    data=$data"$CLASS_NAME::$method() const\n"
	    data=$data"{\n"
	    data=$data"    return (m_$name)\n"
	    data=$data"}\n"
	fi
    done

    echo -e "$data" > $1
}

create_source ()
{
    local data=""

    data=$data"\n#include \"$CLASS_NAME.hh\"\n"

    if [ $DEFAULT_CONSTRUCTOR == $TRUE ]
    then
	    data=$data"\n$CLASS_NAME::$CLASS_NAME()\n"
	    data=$data"{\n"
	    data=$data"}\n"
    fi

    if [ $COPY_CONSTRUCTOR == $TRUE ]
    then
	    data=$data"\n$CLASS_NAME::$CLASS_NAME(const $CLASS_NAME& ref)\n"
	    data=$data"{\n"
	    # TODO copy
	    data=$data"}\n"
    fi

    data=$data"\n$CLASS_NAME::~$CLASS_NAME()\n"
    data=$data"{\n"
    data=$data"}\n"

    echo -e -n "$data" > $1
}

create ()
{
    if [ $# -lt 1 ] || [ $# -gt 3 ]
    then
	echo -e $CREATE_USAGE >&2
	return 2
    else

	# Arguments gathering
	CLASS_NAME=$1
	if [ $# -eq 1 ]
	then
	    include_dir="./"
	    source_dir="./"
	elif [ $# -eq 2 ]
	then
	    include_dir="$2/"
	    source_dir="$2/"
	else
	    include_dir="$2/"
	    source_dir="$3/"
	fi

	source_file="$source_dir$CLASS_NAME.cpp"
	header_file="$include_dir$CLASS_NAME.hh"
	inline_file="$include_dir$CLASS_NAME.hpp"
	MACCRO=$(get_maccro_name $CLASS_NAME)

	CLASS=$(read_boolean "Class or Interface ?" 'c' 'i')
	if [ $CLASS == $TRUE ]
	then
	    ABSTRACT=$(read_boolean "Inheritable ?" 'y' 'n')
	fi
	MOTHER=$(read_string "Inherit from: ")

	if [ $CLASS == $TRUE ]
	then
	    DEFAULT_CONSTRUCTOR=$(read_boolean "Default constructor ?" 'y' 'n')
	    COPY_CONSTRUCTOR=$(read_boolean "Copy constructor ?" 'n' 'y')
	    COPY_CONSTRUCTOR=$(opposite $COPY_CONSTRUCTOR)

	    echo "Members: " >&2
	    while true
	    do
		type=$(read_string "Type: ")
		if [ "$type" == "" ]
		then
		    break
		fi
		name=$(read_string "Name: ")
		getter=$(read_boolean "Getter ?" 'y' 'n')
		
		MEMBERS_TYPES+=("$type")
		MEMBERS_NAMES+=("$name")
		MEMBERS_GETTERS+=("$getter")
		INCLUDES+=("$type")
	    done
	fi

	create_header $header_file
	if (( ${#GETTERS[@]} > 0 ))
	then
	    create_inline $inline_file
	fi
	if [ $CLASS == $TRUE ]
	then
	    create_source $source_file
	fi
    fi
    return 0
}
