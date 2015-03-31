# Makefile Generique

EXT = c
CC = gcc
EXEC = PRG NAME
CFLAGS = -Wall -W 
LDFLAGS =`allegro-config --cflags --libs`


OBJDIR = obj
SRCDIR = srcs
SRC = $(wildcard $(SRCDIR)/*.$(EXT))
OBJ = $(notdir $(SRC:.$(EXT)=.o))
OBJ := $(addprefix $(OBJDIR)/, $(OBJ))

all: $(EXEC) clean

$(EXEC): $(OBJ)
	@$(CC) -o $@ $^ $(LDFLAGS)

$(OBJDIR)/%.o:  $(SRCDIR)/%.$(EXT)
	@mkdir -p $(OBJDIR)
	@$(CC) -o $@ -c $< $(CFLAGS)

clean:
	@rm -rf $(OBJDIR)

install: $(EXEC)
	@cp $(EXEC) /usr/bin/
