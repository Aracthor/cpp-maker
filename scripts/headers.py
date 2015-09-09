#!/usr/bin/python3
## headers.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Wed Sep  9 09:41:38 2015 Aracthor
## Last Update Wed Sep  9 10:06:20 2015 Aracthor
##

class   HeaderWriter:
    def __init__(self, path, project):
        path = path.replace("//", "/")
        last_slash = path.rfind("/")
        self.location = path[:last_slash]
        self.file_name = path[last_slash + 1:]
        self.project = project
        self.user = "TODO"
        self.date = "TODO"

    def emacsWrite(self):
        return ""+\
        "//\n"+\
        "// "+self.file_name+" for "+self.project+" in "+self.location+"\n"+\
        "// \n"+\
        "// Made by "+self.user+"\n"+\
        "// \n"+\
        "// Started on  "+self.date+" "+self.user+"\n"+\
        "// Last Update "+self.date+" "+self.user+"\n"+\
        "//\n"+\
        "\n"
