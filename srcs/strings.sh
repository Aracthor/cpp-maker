#!/bin/bash
## strings.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Tue Jul 28 14:44:41 2015 Aracthor
## Last Update Tue Jul 28 15:02:36 2015 Aracthor
##

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
