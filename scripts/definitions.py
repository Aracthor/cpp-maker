#!/usr/bin/python3
## definitions.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 10:09:33 2015 Aracthor
## Last Update Wed Sep  9 01:23:42 2015 Aracthor
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


# Unexhaustive, of course
NATIVE_TYPES=["char", "short", "int", "long", "float", "double"]

class   Member:
    def __init__(self):
        self.valid = True
        self.pure_type = ""
        self.return_type = ""
        self.name = ""
        self.getter = True
        self.include = None

    def askUserForDefinition(self):
        self.pure_type = string_input("Type: ")
        self.valid = (self.pure_type != "")
        if self.valid:
            self.name = string_input("Name: ")
            self.getter = boolean_input("Getter", True)
            self.calcReturnType()

    def calcReturnType(self):
        self.return_type = self.pure_type
        object_type = self.pure_type
        const = (object_type[:5] == "const")
        if const:
            object_type = object_type[6:]

        object_pure_type = object_type.replace("&", "").replace("*", "")
        pointer_or_ref = object_type != object_pure_type
        if object_pure_type not in NATIVE_TYPES:
            self.include = object_pure_type.replace("::", "/")
            if not const:
                self.return_type = "const " + self.return_type
            if object_pure_type == object_type:
                self.return_type += "&"
        else:
            if pointer_or_ref and not const:
                self.return_type = "const " + self.return_type
            elif const:
                self.return_type = self.return_type[6:]

    def isValid(self):
        return self.valid


class   Definition:
    def __init__(self):
        self.interface = False
        self.default_constructor = False
        self.copy_constructor = False
        self.mother_class = None
        self.final = False
        self.members = []
        self.getters = []

    def askUserForDefinition(self):
        self.interface = boolean_input("Interface", False)
        self.mother_class = string_input("Mother class: ")
        if not self.interface:
            self.default_constructor = boolean_input("Default constructor", True)
            self.copy_constructor = boolean_input("Copy constructor", False)
            self.final = boolean_input("Final", False)

            member = Member()
            member.askUserForDefinition()
            while (member.isValid()):
                self.members.append(member)
                if member.getter:
                    self.getters.append(member)
                member = Member()
                member.askUserForDefinition()
