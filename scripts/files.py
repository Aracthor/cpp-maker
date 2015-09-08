#!/usr/bin/python3
## files.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 10:02:55 2015 Aracthor
## Last Update Wed Sep  9 01:30:49 2015 Aracthor
##

class   File:
    def __init__(self, path):
        self.file = open(path, "w")
        self.data = ""
        self.indentation = "    "

    def write(self, configs, definition):
        self.generateData(configs, definition)
        self.file.write(self.data)

    def writeNamespacesEntry(self, namespaces):
        if len(namespaces) > 0:
            for namespace in namespaces:
                self.writeLine("namespace "+namespace)
                self.writeLine("{")
            self.writeEmptyLine()

    def writeNamespacesExit(self, namespaces):
        if len(namespaces) > 0:
            self.writeEmptyLine()
            for namespace in namespaces:
                self.writeLine("}")

    def writeLine(self, string):
        self.data += string+"\n"

    def writeEmptyLine(self):
        self.data += "\n"

    def close(self):
        self.file.close()


from include_file import IncludeFile
from template_file import TemplateFile
from source_file import SourceFile


class   FileManager:
    def __init__(self, configs, definition):
        self.configs = configs
        self.definition = definition
        self.include_file = IncludeFile(configs.include_file)
        if not definition.interface:
            self.source_file = SourceFile(configs.source_file)
            self.template_file = TemplateFile(configs.template_file)

    def writeFiles(self):
        self.include_file.write(self.configs, self.definition)
        if not self.definition.interface:
            self.source_file.write(self.configs, self.definition)
            self.template_file.write(self.configs, self.definition)

    def close(self):
        self.include_file.close()
        self.template_file.close()
        self.source_file.close()
