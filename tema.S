.data

x : .long 1
y : .long 2
cerinta : .space 4
matrice : .space 1600
coloana : .space 4
linie : .space 4
n : .space 4
legaturi: .space 1600
i : .space 4
j : .space 4
formatScanf : .asciz "%ld"
formatPrintf : .asciz "%ld"
fastprinf : .asciz "%s"
newLine : .asciz "\n"
leg : .space 4
index : .space

.text

.global main

main:

pushl $cerinta
pushl $formatScanf
call scanf
popl %ebx
popl %ebx


movl x , %eax
cmp %eax, cerinta
je et_cerinta1
jmp et_exit

et_cerinta1:

pusha
pushl $n
pushl $formatScanf
call scanf
popl %ebx
popl %ebx
popa

movl $0, %ecx

citire_legaturi:

cmp %ecx,n
je legaturile_nodurilor

pusha
pushl $leg
pushl $formatScanf
call scanf
popl %ebx
popl %ebx
popa

lea legaturi, %edi
movl leg, %ebx
movl %ebx, (%edi, %ecx, 4)

inc %ecx
jmp citire_legaturi

legaturile_nodurilor:

movl $0, %ecx

et_for:
cmp %ecx, n
je afisare

lea legaturi, %edi
movl (%edi, %ecx, 4), %ebx

movl $0, index

et_loop:

cmp %ebx, index
je final_for2

pusha
pushl $j
pushl $formatScanf
call scanf
popl %ebx
popl %ebx
popa

movl %ecx, %eax
movl $0, %edx
mull n
addl j, %eax

lea matrice, %edi
movl $1, (%edi, %eax, 4)

incl index
jmp et_loop

final_for2:
inc %ecx
jmp et_for

afisare:

movl $0, linie

afisare_linie:

movl linie, %ecx
cmp %ecx, n
je et_exit

movl $0, coloana

afisare_coloana:

movl coloana, %ecx
cmp %ecx, n
je spatiu

movl linie, %eax
movl $0, %edx
mull n
addl coloana, %eax

lea matrice, %edi
movl (%edi, %eax, 4), %ebx

pushl %ebx
pushl $formatPrintf
call printf
popl %ebx
popl %ebx

pushl $0
call fflush
popl %ebx

incl coloana
jmp afisare_coloana


spatiu:
movl $4, %eax
movl $1, %ebx
movl $newLine, %ecx
movl $2, %edx
int $0x80

incl linie
jmp afisare_linie

et_exit:

movl $1 , %eax
movl $0 , %ebx
int $0x80

movl $1, %eax
movl $0, %ebx
int $0x80
