.data
s: .space 20
zero: .ascii "0"
one: .ascii "1"

.text
# $s0 n
# $s1 i
# $s2 s
# $t8 "0"
# $t9 "1"

la $t8, zero
lbu $t8, 0($t8)
la $t9, one
lbu $t9, 0($t9)

# read n
li $v0, 5
syscall
move $s0, $v0

# read s
li $s1, 0
For1:
bge $s1, $s0, EndFor1

li $v0, 12
syscall
add $t0, $s2, $s1
sb $v0, 0($t0)

addi $s1, $s1, 1
j For1
EndFor1:

# judge
li $s1, 0
For2:
sra $t0, $s0, 1
bge $s1, $t0, EndFor2

# s[i]
add $t0, $s2, $s1
lbu $t0, 0($t0)

# s[n - i - 1]
sub $t2, $s0, $s1
add $t1, $s2, $t2
lbu $t1, -1($t1)

beq $t0, $t1, Skip

# print "0"
move $a0, $t8
li $v0, 11
syscall

#Exit
li $v0, 10
syscall

Skip:

addi $s1, $s1, 1
j For2
EndFor2:

# print "1"
move $a0, $t9
li $v0, 11
syscall

li $v0, 10
syscall
