#!/usr/bin/python3
## source_file.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 12:03:26 2015 Aracthor
## Last Update Mon Sep  7 21:21:02 2015 Aracthor
##

from files import File

class   SourceFile(File):
    def __init__(self, path):
        File.__init__(self, path)

    def writeIncludeLine(self, configs):
        path = ""
        for namespace in configs.namespaces:
            path += namespace + "/"
        path += configs.class_name + ".hh"
        self.writeLine("#include \""+path+"\"")
        self.writeEmptyLine()

    def writeConstructors(self, class_name, definition):
        if definition.default_constructor:
            self.writeLine(class_name + "::" + class_name + "()")
            self.writeLine("{")
            self.writeLine(self.indentation + "// TODO")
            self.writeLine("}")
            self.writeEmptyLine()

        if definition.copy_constructor:
            self.writeLine(class_name + "::" + class_name + "(const " + class_name + "& reference)")
            self.writeLine("{")
            self.writeLine(self.indentation + "// TODO")
            self.writeLine("}")
            self.writeEmptyLine()

    def writeDestructor(self, class_name):
        self.writeLine(class_name + "::~" + class_name + "()")
        self.writeLine("{")
        self.writeLine(self.indentation + "// TODO")
        self.writeLine("}")

    def generateData(self, configs, definition):
        self.writeIncludeLine(configs)
        self.writeNamespacesEntry(configs.namespaces)

        self.writeConstructors(configs.class_name, definition)
        self.writeDestructor(configs.class_name)

        self.writeNamespacesExit(configs.namespaces)
