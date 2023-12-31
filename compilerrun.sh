#!/bin/bash

set -e

find outputs_asm -mindepth 1 -delete

script_folder="staylang_scripts"

for script in "$script_folder"/*.stay; do
    if [ -f "$script" ] && [ -r "$script" ]; then
        script_name=$(basename "$script" .stay)
        echo "Running compiler/main.py for $script and creating $script_name.asm"
        python3 compiler/main.py "$script"
    else
        echo "Error: $script not found or not readable"
    fi
done

echo "Compiling .asm with gcc"
outputs_folder="outputs_asm"

cd "$outputs_folder"

for assembly in *.asm; do
    if [ -f "$assembly" ] && [ -r "$assembly" ]; then
        echo "Compiling $assembly"
        name="${assembly%.*}"
        nasm -f elf -o "$name".o "$assembly"
        gcc -m32 -no-pie -o "$name" $name.o

        echo "Running $name"
        ./"$name"
        echo
    else
        echo "Error: $assembly not found or not readable"
    fi
done


# echo "Saida ao compilar o arquivo script1.go"
# ./script1