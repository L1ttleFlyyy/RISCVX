`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:32:12 PM
// Design Name: 
// Module Name: ID_EX_stage
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


module ID_EX_stage(
    input clk,
    input reset,
    input stall,
    input flush,
    input WBFF,

    input memread_ID,
    input memwrite_ID,
    input regwrite_ID,
    input j_ID,
    input br_ID,

    input [31:0] PC_ID,
    input [4:0] rs1_ID,
    input [4:0] rs2_ID,
    input [4:0] rd_ID,
    input [31:0] rs1_data_ID,
    input [31:0] rs2_data_ID,
    input jalr_ID,
    input sub_ID,
    input sra_ID,
    input shdir_ID,
    input [2:0] funct3_ID,
    input Asrc_ID,
    input Bsrc_ID,
    input [2:0] ALUOP_ID,
    input [31:0] imm_ID,
    
    output reg memread_EX,
    output reg memwrite_EX,
    output reg regwrite_EX,
    output reg j_EX,
    output reg br_EX,

    output reg [31:0] PC_EX,
    output reg [4:0] rs1_EX,
    output reg [4:0] rs2_EX,
    output reg [4:0] rd_EX,
    output reg [31:0] rs1_data_EX,
    output reg [31:0] rs2_data_EX,
    output reg jalr_EX,
    output reg sub_EX,
    output reg sra_EX,
    output reg shdir_EX,
    output reg [2:0] funct3_EX,
    output reg Asrc_EX,
    output reg Bsrc_EX,
    output reg [2:0] ALUOP_EX,
    output reg [31:0] imm_EX
    );
    
    always@(posedge clk or posedge reset) begin
        if (reset) begin
            memread_EX <= 0;
            memwrite_EX <= 0;
            regwrite_EX <= 0;
            j_EX <= 0;
            br_EX <= 0;
        end else begin
            if (flush || WBFF) begin
                memread_EX <= 0;
                memwrite_EX <= 0;
                regwrite_EX <= 0;
                j_EX <= 0;
                br_EX <= 0;
            end else begin
                if (~stall) begin
                    memread_EX <= memread_ID;
                    memwrite_EX <= memwrite_ID;
                    regwrite_EX <= regwrite_ID;
                    j_EX <= j_ID;
                    br_EX <= br_ID;
                end
            end
        end
    end
    always@(posedge clk) begin
        if (~stall) begin
            PC_EX <= PC_ID;
            rs1_EX <= rs1_ID;
            rs2_EX <= rs2_ID;
            rd_EX <= rd_ID;
            rs1_data_EX <= rs1_data_ID;
            rs2_data_EX <= rs2_data_ID;
            jalr_EX <= jalr_ID;
            sub_EX <= sub_ID;
            sra_EX <= sra_ID;
            shdir_EX <= shdir_ID;
            Asrc_EX <= Asrc_ID;
            Bsrc_EX <= Bsrc_ID;
            funct3_EX <= funct3_ID;
            ALUOP_EX <= ALUOP_ID;
            imm_EX <= imm_ID;
        end
    end
endmodule
