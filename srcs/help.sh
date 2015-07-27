#!/bin/bash
## help.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## Login   <aracthor@epitech.net>
## 
## Started on  Mon Jul 27 16:24:18 2015 Aracthor
## Last Update Mon Jul 27 17:16:24 2015 Aracthor
##

COMMANDS=(
    "create"
    "help"
)

DESCRIPTIONS=(
    "Create new class or interface."
    "Print this help message and exit."
)

function print_usage
{
    message="USAGE: $0 <command> [<args>]\n"
    message="$message\nCommands are:"
    for (( i = 0; i < ${#COMMANDS[@]}; ++i ))
    do
	command=${COMMANDS[$i]}
	description=${DESCRIPTIONS[$i]}
	message="$message\n   $command:\t$description"
    done

    echo -e "$message" >&2
}

function help
{
    print_usage
    return 0
}
