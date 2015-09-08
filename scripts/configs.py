#!/usr/bin/python3
## Configs.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 09:26:11 2015 Aracthor
## Last Update Wed Sep  9 01:30:18 2015 Aracthor
##

class   Configs:
    def __init__(self):
        self.include_folder = "."
        self.source_folder = "."
        self.class_name = ""
        self.namespaces = []

    def read_namespaces(self):
        self.namespaces = self.class_name.split("::")
        self.class_name = self.namespaces[len(self.namespaces) - 1]
        self.namespaces = self.namespaces[:-1]

    def calc_files_paths(self):
        self.include_file = self.include_folder + "/" + self.class_name + ".hh"
        self.template_file = self.include_folder + "/" + self.class_name + ".hpp"
        self.source_file = self.source_folder + "/" + self.class_name + ".cpp"


def read_configs(argv):
    configs = Configs()
    argc = len(argv)
    if (argc != 2 and argc != 3 and argc != 4):
        return False

    configs.class_name = argv[1]
    configs.read_namespaces()
    if (argc == 3):
        configs.include_folder = argv[2]
        configs.source_folder = argv[2]
    elif (argc == 4):
        configs.include_folder = argv[2]
        configs.source_folder = argv[3]

    configs.calc_files_paths()

    return configs
