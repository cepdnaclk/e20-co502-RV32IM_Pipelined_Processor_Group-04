# Initialize registers
addi x1, x0, 1       # x1 = 1 (first Fibonacci number)
addi x2, x0, 1       # x2 = 1 (second Fibonacci number)
addi x3, x0, 10      # x3 = 10 (number of Fibonacci numbers to generate)
addi x5, x0, 0       # x5 = 0 (memory offset)

Loop:
    add x4, x1, x2   # x4 = x1 + x2 (next Fibonacci number)
    sw x1, 0(x5)     # Store current Fibonacci number in memory
    addi x5, x5, 4   # Increment memory offset (word size = 4 bytes)
    addi x3, x3, -1  # Decrement counter
    nop
    nop
    beq x3, x0, End  # Exit loop if counter reaches zero
    nop
    nop
    nop
    add x1, x2, x0   # Update x1 = x2
    add x2, x4, x0   # Update x2 = x4
    jal x0, Loop     # Jump to Loop

End:
    nop              # End of program
