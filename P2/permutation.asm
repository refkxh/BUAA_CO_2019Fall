.data
symbol: .space 7
array: .space 7
nbsp: .ascii " "
endl: .ascii "\n"

.text
main:
# $s0 n
# $s1 symbol
# $s2 array
# $t8 nbsp
# $t9 endl
la $s1, symbol
la $s2, array
la $t8, nbsp
lbu $t8, 0($t8)
la $t9, endl
lbu $t9, 0($t9)

# read n
li $v0, 5
syscall
move $s0, $v0

# call FullArray
li $a0, 0
jal FullArray

li $v0, 10
syscall

FullArray:
# $t0 i

#store $ra
subi $sp, $sp, 4
sw $ra, 0($sp)

blt $a0, $s0, Skip1

li $t0, 0
For1:
bge $t0, $s0, EndFor1

add $t1, $s2, $t0
lbu $a0, 0($t1)
li $v0, 1
syscall

move $a0, $t8
li $v0, 11
syscall

addi $t0, $t0, 1
j For1
EndFor1:

move $a0, $t9
li $v0, 11
syscall

addi $sp, $sp, 4
jr $ra

Skip1:

li $t0, 0
For2:
bge $t0, $s0, EndFor2

add $t1, $s1, $t0
lbu $t2, 0($t1)
bnez $t2, Skip2

addi $t3, $t0, 1
add $t4, $s2, $a0
sb $t3, 0($t4)

li $t3, 1
sb $t3, 0($t1)

# store $a0, $t0, $t1
subi $sp, $sp, 12
sw $a0, 0($sp)
sw $t0, 4($sp)
sw $t1, 8($sp)

# call FullArray
addi $a0, $a0, 1
jal FullArray

# load $a0, $t0, $t1
lw $a0, 0($sp)
lw $t0, 4($sp)
lw $t1, 8($sp)
addi $sp, $sp, 12

sb $0, 0($t1)
Skip2:

addi $t0, $t0, 1
j For2
EndFor2:

# load $ra
lw $ra, 0($sp)
addi $sp, $sp, 4

jr $ra
