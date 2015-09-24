##
## @FILE-NAME@ for @PROJET@ in @PWD@
##
## Made by @USER-NAME@
## @LOGIN-STRING@   <@USER-MAIL@>
##
## Started on  @DATE-STAMP@ @USER-NAME@
## Last update @DATE-STAMP@ @USER-NAME@
##

CC		= gcc

CFLAGS		= -W -Wall -Wextra -pedantic -ansi -I/usr/local/include

LDFLAGS		= -L/usr/local/lib

TARGET		= @FIXME@

SOURCE		= @FIXME@

OBJS		= $(SOURCE:.c=.o)

.PHONY: all clean fclean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) -o $(TARGET) $(OBJS) $(LDFLAGS)

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJS)

fclean: clean
	rm -rf $(TARGET)
