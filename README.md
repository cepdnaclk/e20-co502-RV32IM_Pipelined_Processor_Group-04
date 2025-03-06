___
# RV32IM Pipelined Processor Design
___

## Team

-  E/20/032, Bandara A.M.N.C., [e20032@eng.pdn.ac.lk](mailto:e20032@eng.pdn.ac.lk)
-  E/20/034, Bandara G.M.M.R., [e20034@eng.pdn.ac.lk](mailto:e20034@eng.pdn.ac.lk)
-  E/20/157, Janakantha S.M.B.G., [e20157@eng.pdn.ac.lk](mailto:e20157@eng.pdn.ac.lk)



## Abstract

This project focuses on the design and implementation of a custom 32-bit RISC-V processor supporting the RV32IM instruction set architecture (ISA). Developed as part of the Advanced Computer Architecture course (CO502), the processor encompasses essential features of the RISC-V standard, including integer operations (RV32I) and multiplication/division (M extension).

Key objectives include creating a modular, Verilog-based design with a pipelined architecture to optimize performance. The project will also incorporate testing and verification using simulation tools to ensure accuracy and compliance with the RISC-V specification.

This repository will serve as a collaborative platform to document progress, manage code, and host design files, test benches, and reports. By the project's conclusion, a fully functional RV32IM processor will be available, showcasing an efficient and robust processor design tailored for educational and experimental purposes.

## Features  
- **5-Stage Pipeline**: IF, ID, EX, MEM, WB  
- **Hazard Handling**:  
  - Load-use hazard detection and NOP insertion  
  - Control hazard resolution with branch prediction  
  - Data hazard mitigation via forwarding  
- **Memory Unit**: Supports **load/store operations** (LB, LH, LW, SB, SH, SW)  
- **ALU Operations**: Supports arithmetic, logical, and branching instructions  
- **Register File**: 32 general-purpose registers with asynchronous reads  
- **Instruction Memory (IMEM) & Data Memory (DMEM)**

## Hazard Handling  
The processor handles hazards using the following techniques:  

**Load-Use Hazard**: Detects dependencies between load instructions and subsequent dependent instructions. Inserts a **NOP** and stalls the pipeline.  

**Data Hazard**: Uses a **Forwarding Unit** to forward register values from MEM and WB stages to EX stage.  

**Control Hazard**: Implements **PC freezing and instruction replacement** when a branch is taken.  

## How to Build & Simulate  
### Requirements  
- **VHDL Simulator** (ModelSim, GHDL, Xilinx Vivado)
- **GTKWave**
### Simulate
```
ghdl
ghdl -r main --wave=waveform.ghw
gtkwave waveform.ghw
```
## References
- Hennessy, J. L., & Patterson, D. A. (2020). Computer Architecture: A Quantitative Approach.
- IEEE Std 1800-2019: SystemVerilog—Unified Hardware Design.
