`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:32:12 PM
// Design Name: 
// Module Name: CPU_top
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


module CPU_top(
    input clk,
    input reset,
    input [31:0] data_in,
    input [31:0] addr_in,
    input [1:0] cmd,
    output [31:0] data_out
    );

    // External signal
    wire [31:0] reg_data_e, D_Cache_data_e;
    wire I_Cache_wen_e, D_Cache_wen_e;
    // IF stage signal
    wire [31:0] PC_next, PC_IF, Instr_IF;
    // ID stage signal
    wire stall, WBFF, rs1_valid, rs2_valid, memread_ID, memwrite_ID, regwrite_ID;
    wire j_ID, br_ID, jalr_ID, sub_ID, sra_ID, shdir_ID, Asrc_ID, Bsrc_ID;
    wire [2:0] funct3_ID, ALUOP_ID;
    wire [4:0] rs1_ID, rs2_ID, rd_ID;
    wire [31:0] PC_ID, Instr_ID, rs1_data_ID, rs2_data_ID, imm_ID;
    // EX stage signal
    wire j_br, memread_EX, memwrite_EX, regwrite_EX, j_EX, br_EX;
    wire jalr_EX, sub_EX, sra_EX, shdir_EX, Asrc_EX, Bsrc_EX, EQ, LT, LTU;
    wire [2:0] funct3_EX, ALUOP_EX;
    wire [3:0] mask_EX;
    wire [4:0] rs1_EX, rs2_EX, rd_EX;
    wire [31:0] PC_EX, rs1_data_EX_raw, rs2_data_EX_raw, rs1_data_EX, rs2_data_EX, imm_EX, BTA, ALU_data_EX;
    // MEM stage signal
    wire memread_MEM, regwrite_MEM;
    wire [2:0] funct3_MEM;
    wire [3:0] mask_MEM;
    wire [4:0] rd_MEM;
    wire [31:0] mask_MEM_32, ALU_data_MEM, mem_data_MEM, rd_data_MEM;
    // WB stage signal
    wire regwrite_WB;
    wire [4:0] rd_WB;
    wire [31:0] rd_data_WB;

    // External

    assign I_Cache_wen_e = cmd == 2'b01;
    assign D_Cache_wen_e = cmd == 2'b11;
    assign data_out = 
        (cmd == 2'b00)? reg_data_e :
        (cmd == 2'b01)? Instr_IF : D_Cache_data_e;

    // IF stage

    ProgramCounter PC_0 (
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .j_br(j_br),
    .bta(BTA),
    .PC_IF(PC_IF),
    .PC_next(PC_next)
    );

    I_Cache I_Cache_0 (
    .clka(clk),    // .wire clka
    .wea(I_Cache_wen_e),      // .wire [0 : 0] wea
    .addra(addr_in[31:2]),  // .wire [9 : 0] addra
    .dina(data_in),    // .wire [31 : 0] dina
    .clkb(clk),    // .wire clkb
    .addrb(PC_next[31:2]),  // .wire [9 : 0] addrb
    .doutb(Instr_IF)  // output wire [31 : 0] doutb
    );

    IF_ID_stage IF_ID_stage_0 (
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .flush(j_br),
    .PC_IF(PC_IF),
    .Instr_IF(Instr_IF),
    .PC_ID(PC_ID),
    .Instr_ID(Instr_ID),
    .WBFF(WBFF)
    );

    // ID stage

    DecodingUnit DU_0 (
    .Instr_ID(Instr_ID),
    .DU_rs1_valid(rs1_valid),
    .DU_rs2_valid(rs2_valid),
    .DU_rs1(rs1_ID),
    .DU_rs2(rs2_ID),
    .DU_rd(rd_ID),
    .DU_memread(memread_ID),
    .DU_memwrite(memwrite_ID),
    .DU_regwrite(regwrite_ID),
    .DU_j(j_ID),
    .DU_br(br_ID),
    .DU_jalr(jalr_ID),
    .DU_sub(sub_ID),
    .DU_sra(sra_ID),
    .DU_shdir(shdir_ID),
    .DU_funct3(funct3_ID),
    .DU_Asrc(Asrc_ID),
    .DU_Bsrc(Bsrc_ID),
    .DU_ALUOP(ALUOP_ID),
    .DU_imm(imm_ID)
    );

    RegFile RegFile_0 (
        .clk(clk),
        .rs1(rs1_ID),
        .rs2(rs2_ID),
        .rd(rd_ID),
        .addr_e(addr_in[4:0]),
        .regwrite(regwrite_WB),
        .rd_data(rd_data_WB),
        .rs1_data(rs1_data_ID),
        .rs2_data(rs2_data_ID),
        .data_e(reg_data_e)
    );

    HDU HDU_0 (
    .rs1_ID(rs1_ID),
    .rs2_ID(rs1_ID),
    .rs1_valid(rs1_valid),
    .rs2_valid(rs2_valid),
    .rd_EX(rd_EX),
    .memread_EX(memread_EX),
    .regwrite_EX(regwrite_EX),
    .stall(stall)
    );

    ID_EX_stage ID_EX_stage_0 (
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .flush(j_br),

    .memread_ID(memread_ID),
    .memwrite_ID(memwrite_ID),
    .regwrite_ID(regwrite_ID),
    .j_ID(j_ID),
    .br_ID(br_ID),

    .PC_ID(PC_ID),
    .rs1_ID(rs1_ID),
    .rs2_ID(rs2_ID),
    .rd_ID(rd_ID),
    .rs1_data_ID(rs1_data_ID),
    .rs2_data_ID(rs2_data_ID),
    .jalr_ID(jalr_ID),
    .sub_ID(sub_ID),
    .sra_ID(sra_ID),
    .shdir_ID(shdir_ID),
    .funct3_ID(funct3_ID),
    .Asrc_ID(Asrc_ID),
    .Bsrc_ID(Bsrc_ID),
    .ALUOP_ID(ALUOP_ID),
    .imm_ID(imm_ID),
    
    .memread_EX(memread_EX),
    .memwrite_EX(memwrite_EX),
    .regwrite_EX(regwrite_EX),
    .j_EX(j_EX),
    .br_EX(br_EX),

    .PC_EX(PC_EX),
    .rs1_EX(rs1_EX),
    .rs2_EX(rs2_EX),
    .rd_EX(rd_EX),
    .rs1_data_EX(rs1_data_EX),
    .rs2_data_EX(rs2_data_EX),
    .jalr_EX(jalr_EX),
    .sub_EX(sub_EX),
    .sra_EX(sra_EX),
    .shdir_EX(shdir_EX),
    .funct3_EX(funct3_EX),
    .Asrc_EX(Asrc_EX),
    .Bsrc_EX(Bsrc_EX),
    .ALUOP_EX(ALUOP_EX),
    .imm_EX(imm_EX)
    );

    // EX stage

    FU FU_0 (
    .rs1_EX(rs1_EX),
    .rs2_EX(rs2_EX),
    .rs1_data_raw(rs1_data_EX_raw),
    .rs2_data_raw(rs2_data_EX_raw),
    .regwrite_MEM(regwrite_MEM),
    .regwrite_WB(regwrite_WB),
    .rd_MEM(rd_MEM),
    .rd_WB(rd_WB),
    .rd_data_MEM(ALU_data_MEM),
    .rd_data_WB(rd_data_WB),
    .rs1_data_EX(rs1_data_EX),
    .rs2_data_EX(rs2_data_EX)
    );

    ALU ALU_0 (
    .rs1_data(rs1_data_EX),
    .rs2_data(rs2_data_EX),
    .PC(PC_EX),
    .imm(imm_EX),
    .ALUOP(ALUOP_EX),
    .Asrc(Asrc_EX),
    .Bsrc(Bsrc_EX),
    .sra(sra_EX),
    .shdir(shdir_EX),
    .sub(sub_EX),
    .jalr(jalr_EX),
    .BTA(BTA),
    .EQ(EQ),
    .LT(LT),
    .LTU(LTU),
    .Z(ALU_data_EX)
    );

    BranchUnit BU_0 (
    .j(j_EX),
    .br(br_EX),
    .funct3(funct3_EX),
    .EQ(EQ),
    .LT(LT),
    .LTU(LTU),
    .j_br(j_br)
    );

    LSMask LSMask_0 (
    .memwrite(memwrite_EX),
    .addr(ALU_data_EX[1:0]),
    .funct3(funct3_EX),
    .mask(mask_EX)
    );

    EX_MEM_stage EX_MEM_stage_0 (
    .clk(clk),
    .reset(reset),

    .memread_EX(memread_EX),
    .regwrite_EX(regwrite_EX),
    .mask_EX(mask_EX),
    .rd_EX(rd_EX),
    .ALU_data_EX(ALU_data_EX),

    .memread_MEM(memread_MEM),
    .regwrite_MEM(regwrite_MEM),
    .mask_MEM(mask_MEM),
    .rd_MEM(rd_MEM),
    .ALU_data_MEM(ALU_data_MEM)
    );

    // MEM stage

    D_Cache D_Cache_0 ( // note: shadow reg
    .clka(clk),    // input wire clka
    .ena(memread_EX),      // input wire ena
    .wea(mask_EX),      // input wire [3 : 0] wea
    .addra(ALU_data_EX[31:2]),  // input wire [9 : 0] addra
    .dina(rs2_data_EX),    // input wire [31 : 0] dina
    .douta(mem_data_MEM),  // output wire [31 : 0] douta
    .clkb(clk),    // input wire clkb
    .web(D_Cache_wen_e),      // input wire [3 : 0] web
    .addrb(addr_in[31:2]),  // input wire [9 : 0] addrb
    .dinb(data_in),    // input wire [31 : 0] dinb
    .doutb(D_Cache_data_e)  // output wire [31 : 0] doutb
    );


    assign mask_MEM_32 = 
        (mask_MEM == 4'b1111)? 32'hFFFFFFFF : 
        (mask_MEM == 4'b1100)? 32'hFFFF0000 :
        (mask_MEM == 4'b0011)? 32'h0000FFFF :
        (mask_MEM == 4'b0001)? 32'h000000FF :
        (mask_MEM == 4'b0010)? 32'h0000FF00 :
        (mask_MEM == 4'b0100)? 32'h00FF0000 :
        (mask_MEM == 4'b1000)? 32'hFF000000 : 32'h0;
    assign rd_data_MEM = memread_MEM? (mask_MEM_32 & mem_data_MEM) : ALU_data_MEM;

    MEM_WB_stage MEM_WB_stage_0 (
    .clk(clk),
    .reset(reset),

    .regwrite_MEM(regwrite_MEM),
    .rd_MEM(rd_MEM),
    .rd_data_MEM(rd_data_MEM),

    .regwrite_WB(regwrite_WB),
    .rd_WB(rd_WB),
    .rd_data_WB(rd_data_WB)
    );

    // WB stage

endmodule
