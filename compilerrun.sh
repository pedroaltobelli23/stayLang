#!/bin/bash

set -e

find outputs_asm -mindepth 1 -delete

script_folder="staylang_scripts"

for script in "$script_folder"/script*.stay; do
    if [ -f "$script" ] && [ -r "$script" ]; then
        echo "Running $script and creating $script.asm"
        python3 compiler/main.py "$script"
    else
        echo "Error: $script not found or not readable"
    fi
done

echo "Compiling .asm with gcc"
outputs_folder="outputs_asm"

cd "$outputs_folder"

for assembly in script*.asm; do
    if [ -f "$assembly" ] && [ -r "$assembly" ]; then
        echo "Compiling $assembly"
        name="${assembly%.*}"
        echo "$name"
        nasm -f elf -o "$name".o "$assembly"
        gcc -m32 -no-pie -o "$name" $name.o

        echo "Running $name"
        ./"$name"
    else
        echo "Error: $assembly not found or not readable"
    fi
done


# echo "Saida ao compilar o arquivo script1.go"
# ./script1