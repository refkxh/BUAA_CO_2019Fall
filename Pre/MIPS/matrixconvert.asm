.data
row: .space 200
col: .space 200
val: .space 200
nbsp: .asciiz " "
endl: .asciiz "\n"

.text
#$s0 m
#$s1 n
#$s2 cnt
#$s3 i
#$s4 j
#$s5 tmp

li $s2, 0

#load n, m
li $v0, 5
syscall
move $s1, $v0

li $v0, 5
syscall
move $s0, $v0

li $s3, 1
For0:
slt $t0, $s1, $s3
bnez $t0, Endfor0

li $s4, 1
For1:
slt $t0, $s0, $s4
bnez $t0, Endfor1

#load tmp
li $v0, 5
syscall
move $t1, $v0

beqz $t1, Skip

#save row
la $t0, row
add $t0, $t0, $s2
mul $t0, $t0, 4
sw $s3, 0($t0)

#save column
la $t0, col
add $t0, $t0, $s2
mul $t0, $t0, 4
sw $s4, 0($t0)

#save value
la $t0, val
add $t0, $t0, $s2
mul $t0, $t0, 4
sw $t1, 0($t0)

addi $s2, $s2, 1
Skip:

addi $s4, $s4, 1
j For1
Endfor1:

addi $s3, $s3, 1
j For0
Endfor0:

While:
blez $s2, Endwhile

subi $s2, $s2, 1

#print row
la $t0, row
add $t0, $t0, $s2
mul $t0, $t0, 4
lw $a0, 0($t0)
li $v0, 1
syscall

#print nbsp
la $t0, nbsp
lb $a0, 0($t0)
li $v0, 11
syscall

#print column
la $t0, col
add $t0, $t0, $s2
mul $t0, $t0, 4
lw $a0, 0($t0)
li $v0, 1
syscall

#print nbsp
la $t0, nbsp
lb $a0, 0($t0)
li $v0, 11
syscall

#print value
la $t0, val
add $t0, $t0, $s2
mul $t0, $t0, 4
lw $a0, 0($t0)
li $v0, 1
syscall

#print endl
la $t0, endl
lb $a0, 0($t0)
li $v0, 11
syscall

j While
Endwhile:

li $v0, 10
syscall
