#!/usr/bin/python3
## include_file.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 12:03:26 2015 Aracthor
## Last Update Wed Sep  9 09:57:50 2015 Aracthor
##

from files import File

class   IncludeFile(File):
    def __init__(self, path, project):
        File.__init__(self, path, project)

    def writeIncludes(self, mother, members):
        includes=[]
        if mother:
            includes.append(mother.replace("::", "/"))

        for member in members:
            if member.include and member.include not in includes:
                includes.append(member.include)

        if len(includes) > 0:
            for include in includes:
                self.writeLine("# include \""+include+".hh\"")
            self.writeEmptyLine()

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

    def writeClassPrototype(self, name, definition):
        if definition.mother_class:
            self.writeLine("class\t" + name + " : public " + definition.mother_class)
        else:
            self.writeLine("class\t" + name)
        self.writeLine("{")

        # Constructors
        self.writeLine("public:")
        if definition.default_constructor:
            self.writeLine(self.indentation + name + "();")
        if definition.copy_constructor:
            self.writeLine(self.indentation + name + "(const " + name + "& reference);")

        # Destructor
        if definition.interface:
            self.writeLine(self.indentation + "virtual ~" + name + "() {}")
        elif definition.final:
            self.writeLine(self.indentation + "~" + name + "();")
        else:
            self.writeLine(self.indentation + "virtual ~" + name + "();")

        # Getters
        if len(definition.getters) > 0:
            self.writeEmptyLine()
            self.writeLine("public:")
            for member in definition.getters:
                self.writeLine(self.indentation + "inline " + member.return_type + "\tget" + member.name.title() + "() const;")

        # Members
        if len(definition.members) > 0:
            self.writeEmptyLine()
            if definition.final:
                self.writeLine("private:")
            else:
                self.writeLine("protected:")
            for member in definition.members:
                self.writeLine(self.indentation + member.pure_type + "\tm_" + member.name + ";")

        self.writeLine("};")

    def generateData(self, configs, definition):
        maccro = self.getMaccroName(configs)

        self.writeLine("#ifndef " + maccro)
        self.writeLine("# define " + maccro)
        self.writeEmptyLine()

        self.writeIncludes(definition.mother_class, definition.members)

        self.writeNamespacesEntry(configs.namespaces)

        self.writeClassPrototype(configs.class_name, definition);
        # Stuff here

        self.writeNamespacesExit(configs.namespaces)

        self.writeEmptyLine()
        self.writeLine("# include \"" + configs.class_name + ".hpp\"")

        self.writeEmptyLine()
        self.writeLine("#endif // !" + maccro)
