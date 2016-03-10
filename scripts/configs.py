#!/usr/bin/python3
## Configs.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 09:26:11 2015 Aracthor
## Last Update Mon Oct 19 12:11:43 2015 Vivien Bonnet
##

AVAILLABLE_FLAGS = ["e"]
AVAILLABLE_OPTIONS = ["emacs"]
FLAGS_MEANING = {"e": "emacs"}

class   Configs:
    def __init__(self, argc, argv):
        self.include_folder = "."
        self.source_folder = "."
        self.class_name = ""
        self.namespaces = []
        self.options = []

        args = []
        self.cut_args(argv, args, self.options)
        args_number = len(args)
        if args_number < 1:
            raise Exception("Missing class name")
        elif args_number > 3:
            raise Exception("Too many args...")

        self.class_name = argv[1]
        self.read_namespaces()
        self.read_folders(args_number, args)
        self.calc_files_paths()

    def cut_args(self, argv, args, options):
        for arg in argv[1:]:
            if arg[0] == "-":
                self.add_option(arg, options)
            else:
                args.append(arg)

    def add_option(self, arg, options):
        if arg[1] == "-":
            option = arg[2:]
            if option not in AVAILLABLE_OPTIONS:
                raise Exception("Unknown option " + option)
            options.append(option)
        else:
            flag = arg[1]
            if flag not in AVAILLABLE_FLAGS:
                raise Exception("Unknown flag " + flag)
            options.append(FLAGS_MEANING[flag])

    def read_namespaces(self):
        self.namespaces = self.class_name.split("::")
        self.class_name = self.namespaces[len(self.namespaces) - 1]
        self.namespaces = self.namespaces[:-1]

    def read_folders(self, args_number, args):
        if args_number == 2:
            self.include_folder = args[1]
            self.source_folder = args[1]
        elif args_number == 3:
            self.include_folder = args[1]
            self.source_folder = args[2]

    def calc_files_paths(self):
        self.include_file = self.include_folder + "/" + self.class_name + ".hpp"
        self.template_file = self.include_folder + "/" + self.class_name + ".ipp"
        self.source_file = self.source_folder + "/" + self.class_name + ".cpp"
