#!/bin/bash

cd FlexBisonTokenizerAndParser/

bison -d staylang.y
flex staylang.l

sed -i 's/extern int yylex (void);/extern "C" int yylex(void);/' lex.yy.c
sed -i 's/#define YY_DECL int yylex (void)/#define YY_DECL extern "C" int yylex()/' lex.yy.c

g++ staylang.tab.c lex.yy.c -lfl -o staylang

echo "staylang created!"

echo "Runnig tests:"
cd ../

script_folder="staylang_scripts"

cd "$script_folder"

for script in script*.stay; do
    if [ -f "$script" ] && [ -r "$script" ]; then
        echo "Running $script"
        ../FlexBisonTokenizerAndParser/staylang "$script"
    else
        echo "Error: $script not found or not readable"
    fi
done

cd ../

rm -f staylang.tab.c staylang.tab.h lex.yy.c
