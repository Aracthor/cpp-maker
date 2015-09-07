#!/usr/bin/python2
## setup.py for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Sep  7 22:38:30 2015 Aracthor
## Last Update Mon Sep  7 23:44:08 2015 Aracthor
##

from setuptools import setup
# you may need setuptools instead of distutils

setup(
    # basic stuff here
    scripts = [
        'scripts/configs.py',
        'scripts/cpp-maker',
        'scripts/cpp-maker.py',
        'scripts/definitions.py',
        'scripts/errors.py',
        'scripts/files.py',
        'scripts/include_file.py',
        'scripts/source_file.py',
        'scripts/template_file.py'
    ]
)
