#!/bin/bash

# Run commands
bison -d staylang.y
flex staylang.l

sed -i 's/extern int yylex (void);/extern "C" int yylex(void);/' lex.yy.c
sed -i 's/#define YY_DECL int yylex (void)/#define YY_DECL extern "C" int yylex()/' lex.yy.c

g++ staylang.tab.c lex.yy.c -lfl -o staylang

echo "OUTPUT:"
./staylang

# Remove files if they exist
rm -f staylang.tab.c staylang.tab.h lex.yy.c staylang
