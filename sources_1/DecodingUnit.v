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
    input IFQ_Instr[31:0],
    output DU_rs1[4:0],
    output DU_rs2[4:0],
    output DU_rd[4:0],
    output DU_memread,
    output DU_memwrite,
    output DU_sra_sub,
    output DU_shamt[4:0],
    output DU_j,
    output DU_br,
    output DU_ALUOP[2:0], 
    output DU_regwrite,
    output reg DU_imm[31:0]
    );

    wire opcode[6:0] = IFQ_Instr[6:0];
    wire funct7[6:0] = IFQ_Instr[31:25];
    assign DU_ALUOP[2:0] = IFQ_Instr[14:12];
    assign DU_rd = IFQ_Instr[11:7];
    assign DU_rs1 = IFQ_Instr[19:15];
    assign DU_rs2 = IFQ_Instr[24:20];
    assign DU_shamt = IFQ_Instr[24:20];
    assign DU_sra_sub = funct7 == 7'b0100000;
    assign DU_memread = opcode == 7'b0000011;
    assign DU_memwrite = opcode == 7'b0100011;
    assign DU_j = opcode == 7'b1101111 || opcode == 7'b1100111;
    assign DU_br = opcode == 7'b1100011;
    assign DU_regwrite = raw_regwrite && (DU_rd ~= 5'b0);

    always@(*) begin
        raw_regwrite = 0;
        DU_imm = {IFQ_Instr[31:12], 12'b0};
        if (opcode == 7'b0110111 || opcode == 7'b0010111) begin
        // U-type
            raw_regwrite = 1;
            // DU_imm = {IFQ_Instr[31:12], 12'b0}; default value
        end else if (opcode == 7'b1101111) begin
        // J-type jal
            raw_regwrite = 1;
            DU_imm = {12{IFQ_Instr[31]}, IFQ_Instr[19:12], IFQ_Instr[20], IFQ_Instr[30:25], IFQ_Instr[24:21], 1'b0};
        end else if (opcode == 7'b1100011) begin
        // B-type
            DU_imm = {20{IFQ_Instr[31]}, IFQ_Instr[7], IFQ_Instr[30:25], IFQ_Instr[11:8], 1'b0};
        end else if (opcode == 7'b0100011) begin
        // S-type
            DU_imm = {20{IFQ_Instr[31]}, IFQ_Instr[31:25], IFQ_Instr[11:7]};
        end else if (opcode == 7'0000011 || opcode == 7'b0010011 || opcode == 7'b1100111) begin
        // I-type (LW or ADDI or JALR)
            raw_regwrite = 1;
            DU_imm = {20{IFQ_Instr[31]}, IFQ_Instr[31:20]};
        end else if (opcode == 7'b0110011) begin
        // R-type
            raw_regwrite = 1;
        end

    end

endmodule
