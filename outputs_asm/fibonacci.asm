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
MOV EAX, 0
MOV [EBP-8], EAX
PUSH DWORD 0
MOV EAX, 1
MOV [EBP-12], EAX
PUSH DWORD 0
MOV EAX, 1
MOV [EBP-16], EAX
IF_72:
MOV EAX, 19
PUSH EAX
MOV EAX, [EBP-4]
POP EBX
CMP EAX, EBX
CALL binop_jl
CMP EAX, False
JE ELSE_72
IF_67:
MOV EAX, 0
PUSH EAX
MOV EAX, [EBP-4]
POP EBX
CMP EAX, EBX
CALL binop_je
PUSH EAX
MOV EAX, 1
PUSH EAX
MOV EAX, [EBP-4]
POP EBX
CMP EAX, EBX
CALL binop_je
POP EBX
OR EAX, EBX
CMP EAX, False
JE ELSE_67
IF_35:
MOV EAX, 1
PUSH EAX
MOV EAX, [EBP-4]
POP EBX
CMP EAX, EBX
CALL binop_je
CMP EAX, False
JE ELSE_35
MOV EAX, [EBP-8]
PUSH EAX
PUSH formatout
CALL printf
ADD ESP, 8
MOV EAX, [EBP-12]
PUSH EAX
PUSH formatout
CALL printf
ADD ESP, 8
JMP ENDIF_35
ELSE_35:
MOV EAX, [EBP-8]
PUSH EAX
PUSH formatout
CALL printf
ADD ESP, 8
ENDIF_35:
JMP ENDIF_67
ELSE_67:
MOV EAX, [EBP-8]
PUSH EAX
PUSH formatout
CALL printf
ADD ESP, 8
LOOP_64:
MOV EAX, [EBP-4]
PUSH EAX
MOV EAX, [EBP-16]
POP EBX
CMP EAX, EBX
CALL binop_jl
CMP EAX, False
JE EXIT_64
MOV EAX, [EBP-12]
PUSH EAX
PUSH formatout
CALL printf
ADD ESP, 8
PUSH DWORD 0
MOV EAX, [EBP-8]
MOV [EBP-20], EAX
MOV EAX, [EBP-12]
MOV [EBP-8], EAX
MOV EAX, [EBP-12]
PUSH EAX
MOV EAX, [EBP-20]
POP EBX
ADD EAX, EBX
MOV [EBP-12], EAX
MOV EAX, 1
PUSH EAX
MOV EAX, [EBP-16]
POP EBX
ADD EAX, EBX
MOV [EBP-16], EAX
JMP LOOP_64
EXIT_64:
ENDIF_67:
JMP ENDIF_72
ELSE_72:
MOV EAX, [EBP-4]
PUSH EAX
PUSH formatout
CALL printf
ADD ESP, 8
ENDIF_72:

; interrupcao de saida (default)

PUSH DWORD [stdout]
CALL fflush
ADD ESP, 4

MOV ESP, EBP
POP EBP

MOV EAX, 1
XOR EBX, EBX
INT 0x80