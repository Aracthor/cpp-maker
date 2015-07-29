#!/bin/bash
## booleans.sh for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## Login   <aracthor@epitech.net>
## 
## Started on  Tue Jul 28 12:12:46 2015 Aracthor
## Last Update Wed Jul 29 16:25:01 2015 Aracthor
##

FALSE=0
TRUE=1

opposite ()
{
    if [ $1 == $TRUE ]
    then
	echo $FALSE
    else
	echo $TRUE
    fi
}
