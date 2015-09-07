#!/usr/bin/python3
## include_file.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 12:03:26 2015 Aracthor
## Last Update Mon Sep  7 12:25:46 2015 Aracthor
##

from files import File

class   IncludeFile(File):
    def __init__(self, path):
        File.__init__(self, path)

    def getMaccroName(self, configs):
        maccro = ""
        for namespace in configs.namespaces:
            maccro += namespace.upper() + "_"

        class_name_maccro = configs.class_name
        i = 0
        while i < len(class_name_maccro):
            c = class_name_maccro[i]
            if i > 0 and c >= 'A' and c <= 'Z':
                class_name_maccro = class_name_maccro[:i] + '_' + class_name_maccro[i:]
                i += 1
            elif c >= 'a' and c <= 'z':
                class_name_maccro = class_name_maccro[:i] + class_name_maccro[i].upper() + class_name_maccro[i + 1:]
            i += 1
        maccro += class_name_maccro + "_HH_"

        return maccro

    def generateData(self, configs, definition):
        maccro = self.getMaccroName(configs)
        self.data += "#ifndef "+maccro+"\n"
        self.data += "# define "+maccro+"\n"

        # Stuff here

        self.data += "\n#endif // !"+maccro+"\n"
