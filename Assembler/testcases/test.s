addi x5, x0, 10
addi x1, x5, -50
sub x5, x1, x3
sub x5, x0, x3
mul x5, x1, x3
div x5, x3, x7
rem x5, x1, x7
sw x1, 0(x0)
sub x5, x0, x3
NOP
NOP
lw x7, 0(x0)
add x16, x7, x0
beq x0, x0, -2