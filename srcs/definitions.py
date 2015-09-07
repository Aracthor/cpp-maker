#!/usr/bin/python3
## definitions.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 10:09:33 2015 Aracthor
## Last Update Mon Sep  7 11:04:31 2015 Aracthor
##

def     boolean_input(name, default):
    question = name + " ? "
    if (default == True):
        question += "[Y/n]"
    else:
        question += "[y/N]"

    result = input(question)

    if result == "y" or result == "Y":
        return True
    elif result == "n" or result == "N":
        return False
    elif result == "":
        return default
    else:
        return boolean_input(name, default)

def     string_input(name):
    return input(name)


class   Member:
    def __init__(self):
        self.valid = True
        self.type = ""
        self.name = ""
        self.getter = True

    def askUserForDefinition(self):
        self.type = string_input("Type: ")
        self.valid = (self.type != "")
        if self.valid:
            self.name = string_input("Name: ")
            self.getter = boolean_input("Getter", True)

    def isValid(self):
        return self.valid


class   Definition:
    def __init__(self):
        self.interface = False
        self.default_constructor = True
        self.copy_constructor = False
        self.final = False
        self.members = []

    def askUserForDefinition(self):
        self.interface = boolean_input("Interface", self.interface)
        if not self.interface:
            self.default_constructor = boolean_input("Default constructor", self.default_constructor)
            self.copy_constructor = boolean_input("Copy constructor", self.copy_constructor)
            self.final = boolean_input("Final", self.final)

            member = Member()
            member.askUserForDefinition()
            while (member.isValid()):
                self.members.append(member)
                member.askUserForDefinition()
