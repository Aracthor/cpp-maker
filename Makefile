##
## Makefile for cpp-maker in /home/aracthor/programs/projects/cpp-maker
## 
## Made by Aracthor
## 
## Started on  Mon Jul 27 16:33:13 2015 Aracthor
## Last Update Tue Jul 28 14:51:34 2015 Aracthor
##

CC=		cat
MKDIR=		mkdir
RM=		rm -f
RMDIR=		rmdir
CHMOD=		chmod
INSTALL=	install


PREFIX=		/usr/local
BIN_DIR=	$(PREFIX)/bin


BIN_DIR=	bin/
NAME=		cpp-maker
CPP_MAKER=	$(BIN_DIR)$(NAME)

SRCS_DIR=	srcs/
SRCS_FILES=	booleans.sh	\
		arrays.sh	\
		create.sh	\
		help.sh		\
		reads.sh	\
		strings.sh	\
		cpp-maker.sh
SRCS=		$(SRCS_FILES:%=$(SRCS_DIR)%)



$(CPP_MAKER):	$(BIN_DIR) $(SRCS)
		$(CC) $(SRCS) > $(CPP_MAKER)
		$(CHMOD) +x $(CPP_MAKER)

all:		$(CPP_MAKER)

$(BIN_DIR):
		$(MKDIR) $(BIN_DIR)

clean:
		$(RM) $(CPP_MAKER)
		$(RMDIR) $(BIN_DIR)

re:		clean all

install:	$(CPP_MAKER)
		$(INSTALL) -m 0755 $(NAME) $(BIN_DIR)
