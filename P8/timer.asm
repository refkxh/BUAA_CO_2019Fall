.text
li $t5, 1025
mtc0 $t5, $12
lw $t0, 0x7f2c($0)
sw $t0, 0x7f38($0)
li $t1, 40000000
sw $t1, 0x7f04($0)
li $t2, 11
sw $t2, 0x7f00($0)
Loop:
lw $t3, 0x7f2c($0)
beq $t3, $t0, Loop
nop
sw $t3, 0x7f38($0)
j Loop
move $t0, $t3

.ktext 0x4180
lw $t4, 0x7f38($0)
beqz $t4, Skip
nop
addiu $t4, $t4, -1
Skip:
sw $t4, 0x7f38($0)
eret
