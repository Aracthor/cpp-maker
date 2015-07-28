#!/bin/bash
## reads.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Tue Jul 28 11:51:34 2015 Aracthor
## Last Update Tue Jul 28 14:31:20 2015 Aracthor
##

read_boolean ()
{
    cap2=$(echo $2 | tr '[a-z]' '[A-Z]')
    cap3=$(echo $3 | tr '[a-z]' '[A-Z]')

    while true
    do
	printf "$1 ($cap2/$3)" >&2
	read value
	if [ "$value" == "" ]
	then
	    value=$2
	    break
	elif [ $value == $2 ] || [ $value == $3 ] || [ $value == $cap2 ] || [ $value == $cap3 ]
	then
	    break
	fi
    done

    if [ $value == $2 ] || [ $value == $cap2 ]
    then
	echo $TRUE
    else
	echo $FALSE
    fi
}

read_string ()
{
    printf "$1" >&2
    read value
    echo $value
}
