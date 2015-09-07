#!/usr/bin/python3
## source_file.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 12:03:26 2015 Aracthor
## Last Update Mon Sep  7 12:24:18 2015 Aracthor
##

from files import File

class   SourceFile(File):
    def __init__(self, path):
        File.__init__(self, path)

    def generateData(self, configs, definition):
        pass
