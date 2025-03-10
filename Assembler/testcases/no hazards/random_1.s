addi x10, x0, 5  
addi x11, x0, 10
nop
nop
sw x10, 0(x0)
sw x11, 4(x0)
lw x2, 0(x0)
lw x3, 4(x0)
nop
nop
add x1, x2, x3
nop
nop
sw x1, 8(x0)
lw x12, 8(x0)