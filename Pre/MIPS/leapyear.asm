#Load n to $s0
li $v0, 5
syscall
move $s0, $v0 

li $s1, 0 #$s1 is flag

li $t0, 100
div $s0, $t0
mfhi $t0
beqz $t0, Else1

li $t0, 4
div $s0, $t0
mfhi $t0
bnez $t0, Done
li $s1, 1
j Done

Else1:

li $t0, 400
div $s0, $t0
mfhi $t0
bnez $t0, Done
li $s1, 1
j Done

Done:

#print flag
move $a0, $s1
li $v0, 1
syscall

li $v0, 10
syscall