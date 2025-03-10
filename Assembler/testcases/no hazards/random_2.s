addi x10, x0, 5  
addi x11, x0, 10  
nop  
nop  
sw x10, 8(x0)
sw x11, 12(x0)
lw x2, 8(x0)
lw x3, 12(x0)
nop  
nop  
mul x1, x2, x3  
nop  
nop  
sw x1, 16(x0)
lw x12, 16(x0)