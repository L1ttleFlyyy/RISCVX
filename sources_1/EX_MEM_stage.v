`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:32:12 PM
// Design Name: 
// Module Name: EX_MEM_stage
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


module EX_MEM_stage(
    input clk,
    input reset,
    input flush,

    input memread_EX,
    input regwrite_EX,
    input j_EX,
    input br_EX,
    input EQ_EX,
    input LT_EX,
    input LTU_EX,
    input [2:0] funct3_EX,
    input [4:0] rd_EX,
    input [31:0] BTA_EX,
    input [31:0] ALU_data_EX,

    output reg memread_MEM,
    output reg regwrite_MEM,
    output reg j_MEM,
    output reg br_MEM,
    output reg EQ_MEM,
    output reg LT_MEM,
    output reg LTU_MEM,
    output reg [2:0] funct3_MEM,
    output reg [4:0] rd_MEM,
    output reg [31:0] BTA_MEM,
    output reg [31:0] ALU_data_MEM
    );
    
    always@(posedge clk or posedge reset) begin
        if (reset || flush) begin
            memread_MEM <= 0;
            regwrite_MEM <= 0;
            j_MEM <= 0;
            br_MEM <= 0;
        end else begin
            memread_MEM <= memread_EX;
            regwrite_MEM <= regwrite_EX;
            j_MEM <= j_EX;
            br_MEM <= br_EX;
        end
    end
    
    always@(posedge clk) begin
        funct3_MEM <= funct3_EX;
        rd_MEM <= rd_EX;
        ALU_data_MEM <= ALU_data_EX;
        EQ_MEM <= EQ_EX;
        LT_MEM <= LT_EX;
        LTU_MEM <= LTU_EX;
        BTA_MEM <= BTA_EX;
    end

endmodule
