#!/bin/bash
## cpp-maker.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker/srcs
## 
## Made by Aracthor
## 
## Started on  Mon Jul 27 15:37:35 2015 Aracthor
## Last Update Wed Jul 29 17:04:32 2015 Aracthor
##

set -f

if [ $# -le 0 ]
then
    print_usage
    exit 2
else
    for command in ${COMMANDS[*]};
    do
	if [ $command == $1 ]
	then
	    return_value=$($command $@)
	    exit $return_value
	fi
    done

    return_value=$(create $@)
    exit $return_value
fi
