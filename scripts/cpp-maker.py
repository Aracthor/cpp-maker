#!/usr/bin/python3
## cpp-maker.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 09:19:18 2015 Aracthor
## Last Update Mon Sep  7 12:07:05 2015 Aracthor
##

import sys

from configs import Configs
from configs import read_configs

from definitions import Definition

from errors import print_usage

from files import FileManager

def main(argv):
    configs = read_configs(argv)
    if configs == False:
        return 2

    definition = Definition()
    definition.askUserForDefinition()

    fileManager = FileManager(configs, definition)
    fileManager.writeFiles()
    fileManager.close()

    return 0


if __name__ == "__main__":
    return_value = main(sys.argv)
    if return_value == 2:
        print_usage(sys.argv[0])
    sys.exit(return_value)
