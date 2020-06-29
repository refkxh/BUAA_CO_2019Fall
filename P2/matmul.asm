.data
a: .space 256
b: .space 256
c: .space 256
nbsp: .ascii " "
endl: .ascii "\n"

.macro getaddr(%dest, %base, %row, %col)
sll %dest, %row, 3
add %dest, %dest, %col
sll %dest, %dest, 2
add %dest, %dest, %base
.end_macro

.text
# $s0 n
# $s1 i
# $s2 j
# $s3 k
# $s4 a
# $s5 b
# $s6 c
# $t8 nbsp
# $t9 endl

la $s4, a
la $s5, b
la $s6, c
la $t8, nbsp
la $t9, endl

# read n
li $v0, 5
syscall
move $s0, $v0

# read a
li $s1, 0
For1:
bge $s1, $s0, EndFor1

li $s2, 0
For2:
bge $s2, $s0, EndFor2

li $v0, 5
syscall
getaddr($t0, $s4, $s1, $s2)
sw $v0, 0($t0)

addi $s2, $s2, 1
j For2
EndFor2:

addi $s1, $s1, 1
j For1
EndFor1:

# read b
li $s1, 0
For3:
bge $s1, $s0, EndFor3

li $s2, 0
For4:
bge $s2, $s0, EndFor4

li $v0, 5
syscall
getaddr($t0, $s5, $s1, $s2)
sw $v0, 0($t0)

addi $s2, $s2, 1
j For4
EndFor4:

addi $s1, $s1, 1
j For3
EndFor3:

# calc c
li $s1, 0
For5:
bge $s1, $s0, EndFor5

li $s2, 0
For6:
bge $s2, $s0, EndFor6

li $s3, 0
For7:
bge $s3, $s0, EndFor7

getaddr($t0, $s4, $s1, $s3)
lw $t0, 0($t0)
getaddr($t1, $s5, $s3, $s2)
lw $t1, 0($t1)
mul $t2, $t0, $t1

getaddr($t3, $s6, $s1, $s2)
lw $t4, 0($t3)
add $t4, $t4, $t2
sw $t4, 0($t3)

addi $s3, $s3, 1
j For7
EndFor7:

addi $s2, $s2, 1
j For6
EndFor6:

addi $s1, $s1, 1
j For5
EndFor5:

# print c
li $s1, 0
For8:
bge $s1, $s0, EndFor8

li $s2, 0
For9:
bge $s2, $s0, EndFor9

getaddr($t0, $s6, $s1, $s2)
lw $a0, 0($t0)
li $v0, 1
syscall

move $a0, $t8
lbu $a0, 0($a0)
li $v0, 11
syscall

addi $s2, $s2, 1
j For9
EndFor9:

move $a0, $t9
lbu $a0, 0($a0)
li $v0, 11
syscall

addi $s1, $s1, 1
j For8
EndFor8:

# return
li $v0, 10
syscall