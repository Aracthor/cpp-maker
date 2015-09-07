#!/usr/bin/python3
## template_file.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 12:03:26 2015 Aracthor
## Last Update Mon Sep  7 20:15:24 2015 Aracthor
##

from files import File

class   TemplateFile(File):
    def __init__(self, path):
        File.__init__(self, path)

    def generateData(self, configs, definition):
        self.writeNamespacesEntry(configs.namespaces)

        for member in definition.getters:
            if member != definition.getters[0]:
                self.writeEmptyLine()
            self.writeLine(member.return_type)
            self.writeLine(configs.class_name + "::get" + member.name.title() + "() const")
            self.writeLine("{")
            self.writeLine(self.indentation + "return m_" + member.name + ";")
            self.writeLine("}")

        self.writeNamespacesExit(configs.namespaces)
