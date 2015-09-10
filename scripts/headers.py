#!/usr/bin/python3
## headers.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Wed Sep  9 09:41:38 2015 Aracthor
## Last Update Thu Sep 10 00:11:22 2015 Aracthor
##

import datetime
import os

class   HeaderWriter:
    def __init__(self, path, project):
        path = path.replace("//", "/")
        last_slash = path.rfind("/")
        self.location = os.getenv('PWD')
        if not self.location:
            raise Exception("Cannot get current working directory")
        self.user = os.getenv('USER')
        if not self.user:
            raise Exception("Cannot get user name")

        self.file_name = path[last_slash + 1:]
        self.project = project
        self.date = datetime.datetime.now()

    def emacsWrite(self):
        user = self.user.title()
        date = self.date.strftime("%a %b %2d %H:%M:%S %Y")
        return ""+\
        "//\n"+\
        "// "+self.file_name+" for "+self.project+" in "+self.location+"\n"+\
        "// \n"+\
        "// Made by "+user+"\n"+\
        "// \n"+\
        "// Started on  "+date+" "+user+"\n"+\
        "// Last Update "+date+" "+user+"\n"+\
        "//\n"+\
        "\n"
