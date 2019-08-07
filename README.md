# RISC-V processor in a week!
## Features
- Almost fully support for RV32I instruction set (excluding CSRs and FENCEs)
- 5 stage pipeline with efficient data forwarding
- Middle branch in EX stage
- Implementation verified on Basys 3 dev-board (Xilinx Artix-7 FPGA) running at 100MHz
## ISA
|U-type|J-type|B-type|I-type|S-type|R-type|
|:---:|:---:|:---:|:---:|:---:|:---:|
|LUI|JAL|BEQ|LB|SB|ADD|
|AUIPC||BNE|LH|SH|SUB|
|||BLT|LW|SW|SLL|
|||BGE|LBU||SLT|
|||BLTU|LHU||SLTU|
|||BGEU|ADDI||XOR|
||||SLTI||SRL|
||||SLTIU||SRA|
||||XORI||OR|
||||ORI||AND|
||||ANDI|||
||||SLLI|||
||||SRLI|||
||||JALR|||
