##
## Makefile for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## Login   <aracthor@epitech.net>
## 
## Started on  Mon Jul 27 16:33:13 2015 Aracthor
## Last Update Mon Jul 27 16:39:25 2015 Aracthor
##

CC=		cat
RM=		rm -f
CHMOD=		chmod
INSTALL=	install


PREFIX=		/usr/local
BIN_DIR=	$(PREFIX)/bin


BIN_DIR=	bin/
NAME=		cpp-maker
CPP_MAKER=	$(BIN_DIR)$(NAME)

SRCS_DIR=	srcs/
SRCS_FILES=	create.sh	\
		help.sh		\
		cpp-maker.sh
SRCS=		$(SRCS_FILES:%=$(SRCS_DIR)%)



$(CPP_MAKER):	$(SRCS)
		$(CC) $(SRCS) > $(CPP_MAKER)
		$(CHMOD) +x $(CPP_MAKER)

clean:
		$(RM) $(CPP_MAKER)

install:	$(CPP_MAKER)
		$(INSTALL) -m 0755 $(NAME) $(BIN_DIR)
