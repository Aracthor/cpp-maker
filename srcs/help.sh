#!/bin/bash
## help.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Jul 27 16:24:18 2015 Aracthor
## Last Update Wed Jul 29 17:03:56 2015 Aracthor
##

COMMANDS=(
    "help"
)

DESCRIPTIONS=(
    "Print this help message and exit."
)

print_usage ()
{
    message="USAGE: $0 <command> [<args>] OR:\n"
    message=$message"USAGE: $0 <classname> [<args>]\n"
    message=$message"\nCommands are:"
    for (( i = 0; i < ${#COMMANDS[@]}; ++i ))
    do
	command=${COMMANDS[$i]}
	description=${DESCRIPTIONS[$i]}
	message="$message\n   $command:\t$description"
    done

    echo -e "$message" >&2
}

help ()
{
    print_usage
    return 0
}
