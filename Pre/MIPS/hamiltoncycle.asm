.data
G: .space 81
vis: .space 9

.text
#$s0 m
#$s1 i
#$s2 flag

#$s7 n
#$t8 G
#$t9 vis

#init $t8, $t9
la $t8, G
la $t9, vis

#load n
li $v0, 5
syscall
move $s7, $v0

#load m
li $v0, 5
syscall
move $s0, $v0

li $s1, 0
For0:
slt $t0, $s1, $s0
beqz $t0, Endfor0

li $v0, 5
syscall
move $t0, $v0
li $v0, 5
syscall
move $t1, $v0

li $t4, 9
li $t5, 1
mul $t2, $t0, $t4
mul $t3, $t1, $t4
add $t2, $t2, $t1
add $t3, $t3, $t0
add $t2, $t2, $t8
add $t2, $t2, $t8
sb $t5, 0($t2)
sb $t5, 0($t3)

addi $s1, $s1, 1
j For0
Endfor0:

#call dfs
li $a0, 1
li $a1, 1
jal dfs

move $a0, $v0
li $v0, 1
syscall

li $v0, 10
syscall

dfs:
#$s3 i
#$s4 ret

#save registers
subi $sp, $sp, 12
sw $s3, 0($sp)
sw $s4, 4($sp)
sw $ra, 8($sp)

li $s4, 0

bne $a1, $s7, Skip0
mul $t0, $a0, $t4
addi $t0, $t0, 1
add $t0, $t0, $t8
lb $t0, 0($t0)
beqz $t0, Else
li $s4, 1
j return
Else:
li $s4, 0
j return
Skip0:

add $t7, $t9, $a0
sb $t5, 0($t7)

li $s3, 1
For1:
slt $t0, $s7, $s3
bnez $t0, Endfor1

mul $t0, $a0, $t4
add $t0, $t0, $s3
add $t0, $t0, $t8
lb $t0, 0($t0)
add $t1, $s3, $t9
lb $t1, 0($t1)
xori $t1, $t1, 1
and $t0, $t0, $t1
beqz $t0, Skip1

#call dfs
subi $sp, $sp, 8
sw $a0, 0($sp)
sw $a1, 4($sp)

move $a0, $s3
addi $t0, $a1, 1
move $a1, $t0
jal dfs

lw $a1, 4($sp)
lw $a0, 0($sp)
addi $sp, $sp, 8

or $s4, $s4, $v0

Skip1:

addi $s3, $s3, 1
j For1
Endfor1:

add $t7, $t9, $a0
sb $0, 0($t7)

return:
move $v0, $s4

#recover registers
lw $ra, 8($sp)
lw $s4, 4($sp)
lw $s3, 0($sp)
addi $sp, $sp, 12

jr $ra