#!/bin/bash
## strings.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Tue Jul 28 14:44:41 2015 Aracthor
## Last Update Wed Jul 29 16:13:18 2015 Aracthor
##

get_maccro_name ()
{
    name=$1

    if [ $(there_is_a_namespace $name) == $TRUE ]
    then
	namespace=$(get_class $name)
	class=$(get_class $name)
	name=$namespace"_"$class
    fi

    maccro=$(echo $name | sed 's/[A-Z]/_&/g' | tr '[:lower:]' '[:upper:]')"_HH_"
    echo $maccro | tail -c ${#maccro}
}

there_is_a_namespace ()
{
    result_from_huge_cut=$(echo $1 | cut -d ':' -f 42)
    if [ "$result_from_huge_cut" == "" ]
    then
	echo $TRUE
    else
	echo $FALSE
    fi
}

get_namespace ()
{
    if [ $(there_is_a_namespace $1) == $TRUE ]
    then
	echo $1 | cut -d ':' -f 1
    else
	echo ""
    fi
}

get_class ()
{
    cutted=$(echo $1 | cut -d ':' -f 3)
    if [ "$cutted" == "" ]
    then
	cutted=$1
    fi

    echo $cutted
}

type_is_const ()
{
    type=$1
    if [ ${type:0:5} == "const" ]
    then
	echo $TRUE
    else
	echo $FALSE
    fi
}

read_type ()
{
    echo $1 | tr -d "\*\&"
}
