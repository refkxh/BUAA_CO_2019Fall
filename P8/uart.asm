.text
li $t0, 2049
mtc0 $t0, $12
Loop:
beq $s0, $s1, Loop
lw $t2, 0($s0)
Jump:
lw $t3, 0x7f20($0)
andi $t3, $t3, 32
beqz $t3, Jump
nop
addi $s0, $s0, 4
sw $t2, 0x7f10($0)
j Loop
nop

.ktext 0x4180
lw $t1, 0x7f10($0)
sw $t1, 0($s1)
addi $s1, $s1, 4
eret
