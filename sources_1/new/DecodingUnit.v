`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 01:48:51 PM
// Design Name: 
// Module Name: DecodingUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DecodingUnit(
    input [31:0]IFQ_Instr,
    output DU_rs1_valid,
    output DU_rs2_valid,
    output [4:0]DU_rs1,
    output [4:0]DU_rs2,
    output [4:0]DU_rd,
    output DU_memread,
    output DU_memwrite,
    output DU_regwrite,
    output DU_j,
    output DU_br,
    output DU_jalr,
    output DU_sub,
    output DU_sra,
    output DU_shdir,
    output DU_funct3,
    output DU_Asrc,
    output DU_Bsrc,
    output [2:0]DU_ALUOP,
    output reg [31:0]DU_imm
    );

    reg raw_regwrite;
    wire[6:0] opcode = IFQ_Instr[6:0];
    wire[6:0] funct7 = IFQ_Instr[31:25];
    wire[2:0] funct3 = IFQ_Instr[14:12];
    wire LUI = opcode == 7'b0110111;
    wire AUIPC = opcode == 7'b0010111;
    wire JAL = opcode == 7'b1101111;
    wire JALR = opcode == 7'b1100111;
    wire B_type = opcode == 7'b1100011;
    wire R_type = opcode == 7'b0110011;
    wire I_type = opcode == 7'b0010011; // excluding LW and JALR
    wire L_type = opcode == 7'b0000011;
    wire S_type = opcode == 7'b0100011;

    assign DU_ALUOP[2:0] = (I_type || R_type)? funct3 : 3'b0; // used only when R-type and corresponding I-type
    assign DU_rd = IFQ_Instr[11:7];
    assign DU_rs1 = LUI? 5'b0 : IFQ_Instr[19:15];
    assign DU_rs2 = IFQ_Instr[24:20];
    assign DU_rs1_valid = ~(LUI || AUIPC || JAL);
    assign DU_rs2_valid = (B_type || S_type || R_type);
    assign DU_sra = funct7 == 7'b0100000;
    assign DU_shdir = funct3 == 3'b001; // shift left
    assign DU_sub = (funct7 == 7'b0100000) & R_type;
    assign DU_memread = L_type;
    assign DU_memwrite = S_type;
    assign DU_j = JAL || JALR;
    assign DU_jalr = JALR;
    assign DU_br = B_type;
    assign DU_regwrite = raw_regwrite && (DU_rd != 5'b0);
    assign DU_Asrc = AUIPC || JAL || JALR; // 1: PC 0: (Rs1)
    assign DU_Bsrc = ~(R_type || B_type); // 1: Imm (including PC + 4 for jalr) 0: (Rs2)
    assign DU_funct3 = funct3;

    always@(*) begin
        raw_regwrite = 0;
        DU_imm = {IFQ_Instr[31:12], 12'b0};
        if (LUI || AUIPC) begin // U-type
            raw_regwrite = 1;
            // DU_imm = {IFQ_Instr[31:12], 12'b0}; default value
        end else if (JAL) begin // J-type jal
            raw_regwrite = 1;
            DU_imm = {{12{IFQ_Instr[31]}}, IFQ_Instr[19:12], IFQ_Instr[20], IFQ_Instr[30:25], IFQ_Instr[24:21], 1'b0};
        end else if (B_type) begin // B-type
            DU_imm = {{20{IFQ_Instr[31]}}, IFQ_Instr[7], IFQ_Instr[30:25], IFQ_Instr[11:8], 1'b0};
        end else if (S_type) begin // S-type
            DU_imm = {{20{IFQ_Instr[31]}}, IFQ_Instr[31:25], IFQ_Instr[11:7]};
        end else if (L_type || I_type || JALR) begin // I-type (LW or ADDI or JALR)
            raw_regwrite = 1;
            DU_imm = {{20{IFQ_Instr[31]}}, IFQ_Instr[31:20]};
        end else if (R_type) begin // R-type
            raw_regwrite = 1;
        end
    end

endmodule
