#!/bin/bash
## arrays.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Tue Jul 28 14:22:21 2015 Aracthor
## Last Update Tue Jul 28 14:30:56 2015 Aracthor
##

array_contains ()
{
    local array="$1[@]"
    local seeking=$2
    local in=$FALSE
    for element in "${!array}"; do
        if [[ $element == $seeking ]]; then
            in=$TRUE
            break
        fi
    done
    echo $in
}
