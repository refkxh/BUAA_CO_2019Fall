.data
M: .space 64
vis: .space 64

.macro getaddr(%dest, %base, %row, %col)
sll %dest, %row, 3
add %dest, %dest, %col
add %dest, %dest, %base
.end_macro

.text
main:
# $s0 n
# $s1 m
# $s2 tx
# $s3 ty
# $s4 ans
# $t8 M
# $t9 vis

# $t0 i
# $t1 j
# $t2 sx
# $t3 sy
li $s4, 0
la $t8, M
la $t9, vis

# read n
li $v0, 5
syscall
move $s0, $v0

# read m
li $v0, 5
syscall
move $s1, $v0

#read M
li $t0, 1
For1:
bgt $t0, $s0, EndFor1

li $t1, 1
For2:
bgt $t1, $s1, EndFor2

getaddr($t4, $t8, $t0, $t1)
li $v0, 5
syscall
sb $v0, 0($t4)

addi $t1, $t1, 1
j For2
EndFor2:

addi $t0, $t0, 1
j For1
EndFor1:

# read sx
li $v0, 5
syscall
move $t2, $v0

# read sy
li $v0, 5
syscall
move $t3, $v0

# read tx
li $v0, 5
syscall
move $s2, $v0

# read ty
li $v0, 5
syscall
move $s3, $v0

# set vis[sx][sy] to 1
getaddr($t4, $t9, $t2, $t3)
li $t5, 1
sb $t5, 0($t4)

#call dfs
move $a0, $t2
move $a1, $t3
jal dfs

# print ans
move $a0, $s4
li $v0, 1
syscall

li $v0, 10
syscall

dfs:
# $t0 dx
# $t1 dy

# store $ra
subi $sp, $sp, 4
sw $ra, 0($sp)

bne $a0, $s2, Skip1
bne $a1, $s3, Skip1

addi $s4, $s4, 1

addi $sp, $sp, 4
jr $ra

Skip1:

subi $t0, $a0, 1

ble $t0, $0, Skip2
bgt $t0, $s0, Skip2
getaddr($t2, $t9, $t0, $a1)
lb $t2, 0($t2)
bnez $t2, Skip2
getaddr($t2, $t8, $t0, $a1)
lb $t2, 0($t2)
bnez $t2, Skip2

# set vis[dx][cury] to 1
getaddr($t2, $t9, $t0, $a1)
li $t3, 1
sb $t3, 0($t2)

# call dfs
subi $sp, $sp, 16
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $a0, 8($sp)
sw $a1, 12($sp)

move $a0, $t0
jal dfs

lw $a1, 12($sp)
lw $a0, 8($sp)
lw $t1, 4($sp)
lw $t0, 0($sp)
addi $sp, $sp, 16

# set vis[dx][cury] to 0
getaddr($t2, $t9, $t0, $a1)
sb $0, 0($t2)

Skip2:

addi $t0, $a0, 1

ble $t0, $0, Skip3
bgt $t0, $s0, Skip3
getaddr($t2, $t9, $t0, $a1)
lb $t2, 0($t2)
bnez $t2, Skip3
getaddr($t2, $t8, $t0, $a1)
lb $t2, 0($t2)
bnez $t2, Skip3

# set vis[dx][cury] to 1
getaddr($t2, $t9, $t0, $a1)
li $t3, 1
sb $t3, 0($t2)

# call dfs
subi $sp, $sp, 16
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $a0, 8($sp)
sw $a1, 12($sp)

move $a0, $t0
jal dfs

lw $a1, 12($sp)
lw $a0, 8($sp)
lw $t1, 4($sp)
lw $t0, 0($sp)
addi $sp, $sp, 16

# set vis[dx][cury] to 0
getaddr($t2, $t9, $t0, $a1)
sb $0, 0($t2)

Skip3:

subi $t1, $a1, 1

ble $t1, $0, Skip4
bgt $t1, $s1, Skip4
getaddr($t2, $t9, $a0, $t1)
lb $t2, 0($t2)
bnez $t2, Skip4
getaddr($t2, $t8, $a0, $t1)
lb $t2, 0($t2)
bnez $t2, Skip4

# set vis[curx][dy] to 1
getaddr($t2, $t9, $a0, $t1)
li $t3, 1
sb $t3, 0($t2)

# call dfs
subi $sp, $sp, 16
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $a0, 8($sp)
sw $a1, 12($sp)

move $a1, $t1
jal dfs

lw $a1, 12($sp)
lw $a0, 8($sp)
lw $t1, 4($sp)
lw $t0, 0($sp)
addi $sp, $sp, 16

# set vis[curx][dy] to 0
getaddr($t2, $t9, $a0, $t1)
sb $0, 0($t2)

Skip4:

addi $t1, $a1, 1

ble $t1, $0, Skip5
bgt $t1, $s1, Skip5
getaddr($t2, $t9, $a0, $t1)
lb $t2, 0($t2)
bnez $t2, Skip5
getaddr($t2, $t8, $a0, $t1)
lb $t2, 0($t2)
bnez $t2, Skip5

# set vis[curx][dy] to 1
getaddr($t2, $t9, $a0, $t1)
li $t3, 1
sb $t3, 0($t2)

# call dfs
subi $sp, $sp, 16
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $a0, 8($sp)
sw $a1, 12($sp)

move $a1, $t1
jal dfs

lw $a1, 12($sp)
lw $a0, 8($sp)
lw $t1, 4($sp)
lw $t0, 0($sp)
addi $sp, $sp, 16

# set vis[curx][dy] to 0
getaddr($t2, $t9, $a0, $t1)
sb $0, 0($t2)

Skip5:

# load $ra
lw $ra, 0($sp)
addi $sp, $sp, 4

jr $ra