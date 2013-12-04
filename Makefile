# makefile for srlua

# JvH - edited to reflect lua 5.1 locations in stock ubuntu.
LUA= /usr/include/lua5.1
LUAINC= $(LUA)
LUALIB= /usr/lib/lua/5.1
LUABIN= /usr/bin

# these will probably work if Lua has been installed globally
#LUA= /usr/local
#LUAINC= $(LUA)/include
#LUALIB= $(LUA)/lib
#LUABIN= $(LUA)/bin

# probably no need to change anything below here
CC= gcc
CFLAGS= $(INCS) $(WARN) -O2 $G
WARN= -ansi -pedantic -Wall -Wextra
INCS= -I$(LUAINC)
LIBS= -L$(LUALIB) -llua5.1 -lm -ldl
EXPORT= -Wl,-E
# for Mac OS X comment the previous line above or do 'make EXPORT='

T= a.out
S= srlua
OBJS= srlua.o
TEST= test.lua

all:	test

test:	$T
	./$T *

$T:	$S $(TEST) glue
	./glue $S $(TEST) $T
	chmod +x $T

$S:	$(OBJS)
	$(CC) -o $@ $(EXPORT) $(OBJS) $(LIBS)

clean:
	rm -f $(OBJS) $T $S core core.* a.out *.o glue

# eof
