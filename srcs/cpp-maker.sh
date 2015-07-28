#!/bin/bash
## cpp-maker.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker/srcs
## 
## Made by Aracthor
## 
## Started on  Mon Jul 27 15:37:35 2015 Aracthor
## Last Update Tue Jul 28 14:31:16 2015 Aracthor
##

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
    echo "$0 $1 is not a cpp-maker command. See $0 help for commands list." 1>&2
    exit 2
fi
