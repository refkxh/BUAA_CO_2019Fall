.data
m: .space 1024
core: .space 1024
endl: .ascii "\n"
nbsp: .ascii " "

.macro getaddr(%dest, %base, %row, %col)
sll $t5, %row, 4
add $t5, $t5, %col
sll $t5, $t5, 2
add %dest, %base, $t5
.end_macro

.text
# $s0 m1 or m1 - m2
# $s1 n1 or n1 - n2
# $s2 m2
# $s3 n2
# $s4 i
# $s5 j
# $s6 k
# $s7 l
# $t0 ans
# $t8 m
# $t9 core
# $t7 endl
# $t6 nbsp
la $t8, m
la $t9, core
la $t7, endl
lbu $t7, 0($t7)
la $t6, nbsp
lbu $t6, 0($t6)

# read m1
li $v0, 5
syscall
move $s0, $v0

# read n1
li $v0, 5
syscall
move $s1, $v0

# read m2
li $v0, 5
syscall
move $s2, $v0

# read n2
li $v0, 5
syscall
move $s3, $v0

# read m
li $s4, 0
For1:
bge $s4, $s0, EndFor1

li $s5, 0
For2:
bge $s5, $s1, EndFor2

li $v0, 5
syscall
getaddr($t1, $t8, $s4, $s5)
sw $v0, 0($t1)

addi $s5, $s5, 1
j For2
EndFor2:

addi $s4, $s4, 1
j For1
EndFor1:

# read core
li $s4, 0
For3:
bge $s4, $s2, EndFor3

li $s5, 0
For4:
bge $s5, $s3, EndFor4

li $v0, 5
syscall
getaddr($t1, $t9, $s4, $s5)
sw $v0, 0($t1)

addi $s5, $s5, 1
j For4
EndFor4:

addi $s4, $s4, 1
j For3
EndFor3:

# calc
sub $s0, $s0, $s2
sub $s1, $s1, $s3

li $s4, 0
For5:
bgt $s4, $s0, EndFor5

li $s5, 0
For6:
bgt $s5, $s1, EndFor6

li $t0, 0

li $s6, 0
For7:
bge $s6, $s2, EndFor7

li $s7, 0
For8:
bge $s7, $s3, EndFor8

add $t1, $s4, $s6
add $t2, $s5, $s7
getaddr($t3, $t8, $t1, $t2)
lw $t3, 0($t3)
getaddr($t4, $t9, $s6, $s7)
lw $t4, 0($t4)
mul $t3, $t3, $t4
add $t0, $t0, $t3

addi $s7, $s7, 1
j For8
EndFor8:

addi $s6, $s6, 1
j For7
EndFor7:

# print ans
move $a0, $t0
li $v0, 1
syscall

# nbsp
move $a0, $t6
li $v0, 11
syscall

addi $s5, $s5, 1
j For6
EndFor6:

# endl
move $a0, $t7
li $v0, 11
syscall

addi $s4, $s4, 1
j For5
EndFor5:

li $v0, 10
syscall
