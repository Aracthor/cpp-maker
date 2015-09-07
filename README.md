# cpp-maker
C++ class generator.

## Usage
Three runs are possible:

    ./cpp-maker <classname>
    ./cpp-maker <classname> <folder>
    ./cpp-maker <classname> <include folder> <source folder>

On the first option, include and source folders shall be `./`.  
On the seconde one, both shall be the `<folder>` argument.  
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

    cpp-maker foo::Toto

Shall generate a class `Toto` inside the namespace `foo`.

It works with more than one namespace. Just enter the complete path to your class :

    cpp-maker foo::bar::Toto

Shall generate a class `Toto` inside the namespace `bar` inside the namespace `foo`.
