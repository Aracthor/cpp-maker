#!/usr/bin/python3
## setup.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 22:38:30 2015 Aracthor
## Last Update Wed Sep  9 16:17:13 2015 Aracthor
##

from distutils.core import setup
# you may need setuptools instead of distutils

setup(
    # basic stuff here
    scripts = [
        'scripts/configs.py',
        'scripts/cpp-maker',
        'scripts/definitions.py',
        'scripts/errors.py',
        'scripts/files.py',
        'scripts/headers.py',
        'scripts/include_file.py',
        'scripts/main.py',
        'scripts/source_file.py',
        'scripts/template_file.py'
    ]
)
