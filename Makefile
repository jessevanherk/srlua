# makefile for srlua

# JvH - edited to reflect lua 5.1 locations in stock ubuntu.
LUA= /usr/include/lua5.1
LUAINC= $(LUA)
LUALIB= /usr/lib/lua/5.1
LUABIN= /usr/bin

# probably no need to change anything below here
CC= gcc
CFLAGS= $(INCS) $(WARN) -O2 $G
WARN= -ansi -pedantic -Wall -Wextra
INCS= -I$(LUAINC)
LIBS= -L$(LUALIB) -llua5.1 -lm -ldl
EXPORT= -Wl,-E
# for Mac OS X comment the previous line above or do 'make EXPORT='

TESTBIN= a.out
RUNNER= srlua
OBJS= srlua.o
TESTSCRIPT= test.lua
BINS= glue $(RUNNER)
BIN_DEST= /usr/local/bin

all: srlua glue

install: $(BINS)
	install --mode=755 glue $(BIN_DEST)
	install --mode=755 $(RUNNER) $(BIN_DEST)

test:	$(TESTBIN)
	./$(TESTBIN) *

$(TESTBIN):	$(RUNNER) $(TESTSCRIPT) glue
	./glue $(RUNNER) $(TESTSCRIPT) $(TESTBIN)
	chmod +x $(TESTBIN)

srlua:	$(OBJS)
	$(CC) -o $@ $(EXPORT) $(OBJS) $(LIBS)

clean:
	rm -f $(OBJS) $(TESTBIN) $(RUNNER) core core.* $(TESTBIN) *.o glue

# eof
