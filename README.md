# cpp-maker
C++ class generator.

## Usage
Two runs are possible:

    cpp-maker <classname> [<folder>]
    cpp-maker <classname> [<include folder>] [<source folder>]

The include folder contains `.hh` and optional `.hpp` files, and the source folder contains the `.cpp` file.

When you run it, you have to enter the name of the project, then five boolean questions :

 - Is it a class or an interface ?
 - Is it a final or an heritable class ?
 - Does it have a mother class ?
 - Does it have a default constructor ?
 - Does it have a copy constructor ?

Note that if you choose to create an interface, the only left question would be for the mother interface. Every other question is jumped.

Then, if you didn't choose to create an interface, you can then define as many members as you want. You define each one with 3 questions :

 - Its type (char, int, class, etc).
 - Its name.
 - If you want to generate a getter function for this member.

When you are over, just enter a blank on the type question to generate your files.

## Namespace

You can generate a class with a specific namespace. Just enter it with the namespace path in arguments :

    cpp-maker foo::Bar

Shall generate a class `Bar` inside the namespace `foo`.

**WARNING** : nothing works for now with more than one namespace on the same name. So don't try to create something like `foo::bar::Toto`.

## Todo
Complete remake in another language, **shell** was a terrible idea.

A new version is currently in development on branch `python`, and it is, as its names implies, in **Python 3**.
