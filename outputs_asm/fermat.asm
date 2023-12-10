; constantes
SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1
True equ 1
False equ 0

segment .data

formatin: db "%d", 0
formatout: db "%d", 10, 0 ; newline, nul terminator
scanint: times 4 db 0 ; 32bits integer = 4 bytes

segment .bss  ; variaveis
res RESB 1
extern fflush
extern stdout

section .text
global main ; linux
extern scanf ; linux
extern printf ; linux
extern fflush ; linux
extern stdout ; linux

; subrotinas if/while
binop_je:
JE binop_true
JMP binop_false

binop_jg:
JG binop_true
JMP binop_false

binop_jl:
JL binop_true
JMP binop_false

binop_false:
MOV EAX, False  
JMP binop_exit
binop_true:
MOV EAX, True
binop_exit:
RET

main:

PUSH EBP ; guarda o base pointer
MOV EBP, ESP ; estabelece um novo base pointer

; codigo gerado pelo compilador abaixo



PUSH DWORD 0
PUSH scanint
PUSH formatin
call scanf
ADD ESP, 8
MOV EAX, DWORD [scanint]
MOV [EBP-4], EAX
PUSH DWORD 0
MOV EAX, 3
MOV [EBP-8], EAX
PUSH DWORD 0
PUSH scanint
PUSH formatin
call scanf
ADD ESP, 8
MOV EAX, DWORD [scanint]
MOV [EBP-12], EAX
PUSH DWORD 0
PUSH scanint
PUSH formatin
call scanf
ADD ESP, 8
MOV EAX, DWORD [scanint]
MOV [EBP-16], EAX
PUSH DWORD 0
MOV EAX, 4
MOV [EBP-20], EAX
PUSH DWORD 0
MOV EAX, 1
MOV [EBP-24], EAX
PUSH DWORD 0
MOV EAX, 0
MOV [EBP-28], EAX
PUSH DWORD 0
PUSH DWORD 0
IF_74:
MOV EAX, 3
PUSH EAX
MOV EAX, [EBP-4]
POP EBX
CMP EAX, EBX
CALL binop_jl
CMP EAX, False
JE ELSE_74
MOV EAX, [EBP-4]
PUSH EAX
PUSH formatout
CALL printf
ADD ESP, 8
JMP ENDIF_74
ELSE_74:
LOOP_71:
MOV EAX, [EBP-4]
PUSH EAX
MOV EAX, [EBP-8]
POP EBX
CMP EAX, EBX
CALL binop_jl
CMP EAX, False
JE EXIT_71
MOV EAX, [EBP-8]
PUSH EAX
MOV EAX, [EBP-16]
POP EBX
MOV ECX, EBX
SUB ECX, 1
MOV EBX, EAX
POWER_40:
MUL EBX
LOOP POWER_40
PUSH EAX
MOV EAX, [EBP-8]
PUSH EAX
MOV EAX, [EBP-12]
POP EBX
MOV ECX, EBX
SUB ECX, 1
MOV EBX, EAX
POWER_37:
MUL EBX
LOOP POWER_37
POP EBX
ADD EAX, EBX
MOV [EBP-32], EAX
MOV EAX, [EBP-8]
PUSH EAX
MOV EAX, [EBP-20]
POP EBX
MOV ECX, EBX
SUB ECX, 1
MOV EBX, EAX
POWER_47:
MUL EBX
LOOP POWER_47
MOV [EBP-36], EAX
MOV EAX, [EBP-32]
PUSH EAX
PUSH formatout
CALL printf
ADD ESP, 8
MOV EAX, [EBP-36]
PUSH EAX
PUSH formatout
CALL printf
ADD ESP, 8
IF_63:
MOV EAX, [EBP-36]
PUSH EAX
MOV EAX, [EBP-32]
POP EBX
CMP EAX, EBX
CALL binop_je
CMP EAX, False
JE ELSE_63
MOV EAX, [EBP-24]
PUSH EAX
PUSH formatout
CALL printf
ADD ESP, 8
JMP ENDIF_63
ELSE_63:
MOV EAX, [EBP-28]
PUSH EAX
PUSH formatout
CALL printf
ADD ESP, 8
ENDIF_63:
MOV EAX, 1
PUSH EAX
MOV EAX, [EBP-8]
POP EBX
ADD EAX, EBX
MOV [EBP-8], EAX
JMP LOOP_71
EXIT_71:
ENDIF_74:

; interrupcao de saida (default)

PUSH DWORD [stdout]
CALL fflush
ADD ESP, 4

MOV ESP, EBP
POP EBP

MOV EAX, 1
XOR EBX, EBX
INT 0x80