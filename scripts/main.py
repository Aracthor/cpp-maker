#!/usr/bin/python3
## cpp-maker.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 09:19:18 2015 Aracthor
## Last Update Wed Sep  9 09:55:50 2015 Aracthor
##

import sys

from configs import Configs

from definitions import Definition

from errors import print_usage

from files import FileManager

def main(argc, argv):
    configs = Configs(argc, argv)
    if configs == False:
        return 2

    definition = Definition()
    definition.askUserForDefinition(configs.options)

    fileManager = FileManager(configs, definition)
    fileManager.writeFiles()
    fileManager.close()

    return 0


if __name__ == "__main__":
    return_value = main(len(sys.argv), sys.argv)
    if return_value == 2:
        print_usage(sys.argv[0])
    sys.exit(return_value)
