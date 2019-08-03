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
    wire stall, WBFF, rs1_valid, rs2_valid, memread_ID, memwrite_ID, regwrite_ID
    wire j_ID, br_ID, jalr_ID, sub_ID, sra_ID, shdir_ID, Asrc_ID, Bsrc_ID;
    wire [2:0] funct3_ID, ALUOP_ID;
    wire [4:0] rs1_ID, rs2_ID, rd_ID;
    wire [31:0] PC_ID, Instr_ID, rs1_data_ID, rs2_data_ID, imm_ID;
    // EX stage signal
    wire j_br, memread_EX, memwrite_EX, regwrite_EX, j_EX, br_EX;
    wire j_EX, br_EX, jalr_EX, sub_EX, sra_EX, shdir_EX, Asrc_EX, Bsrc_EX, EQ, LT, LTU;
    wire [2:0] funct3_EX, ALUOP_EX;
    wire [4:0] rs1_EX, rs2_EX, rd_EX;
    wire [31:0] PC_EX, rs1_data_EX_raw, rs2_data_EX_raw, rs1_data_EX, rs2_data_EX, imm_EX, BTA, Z;
    // MEM stage signal
    wire memread_MEM, memwrite_MEM, regwrite_MEM;
    wire [2:0] funct3_EX;
    wire [3:0] mask;
    wire [4:0] rd_MEM;
    wire [31:0] ALU_data_MEM, mem_data_MEM;
    // WB stage signal
    wire memread_WB, regwrite_WB;
    wire [4:0] rd_WB;
    wire [31:0] ALU_data_WB, mem_data_WB;

    I_Cache your_instance_name (
    .clka(clk),    // input wire clka
    .wea(I_Cache_wen_e),      // input wire [0 : 0] wea
    .addra(addr_in),  // input wire [9 : 0] addra
    .dina(data_in),    // input wire [31 : 0] dina
    .clkb(clk),    // input wire clkb
    .addrb(PC_next),  // input wire [9 : 0] addrb
    .doutb(Instr_IF)  // output wire [31 : 0] doutb
    );

    // ID stage
    RegFile RegFile_0 (
        .clk(clk),
        .rs1(rs1_ID),
        .rs2(rs2_ID),
        .rd(rd_ID),
        .addr_e(addr_in[4:0]),
        .regwrite_e(regwrite_WB),
        .rd_data(rd_data_WB),
        .rs1_data(rs1_data_ID),
        .rs2_data(rs2_data_ID),
        .data_e(reg_data_e)
    );

endmodule
