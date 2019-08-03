`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:32:12 PM
// Design Name: 
// Module Name: FU
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


module FU(
    input [4:0] rs1_EX,
    input [4:0] rs2_EX,
    input [31:0] rs1_data_raw,
    input [31:0] rs2_data_raw,
    input regwrite_MEM,
    input regwrite_WB,
    input [4:0] rd_MEM,
    input [4:0] rd_WB,
    input [31:0] rd_data_MEM,
    input [31:0] rd_data_WB,
    output reg [31:0] rs1_data_EX,
    output reg [31:0] rs2_data_EX
    );
    
    always@ (*) begin
        if (regwrite_MEM && (rs1_EX == rd_MEM)) begin
            rs1_data_EX = rd_data_MEM;
        end else if (regwrite_WB && (rs1_EX == rd_WB)) begin
            rs1_data_EX = rd_data_WB;
        end else begin
            rs1_data_EX = rs1_data_raw;
        end

        if (regwrite_MEM && (rs2_EX == rd_MEM)) begin
            rs2_data_EX = rd_data_MEM;
        end else if (regwrite_WB && (rs2_EX == rd_WB)) begin
            rs2_data_EX = rd_data_WB;
        end else begin
            rs2_data_EX = rs2_data_raw;
        end

    end

endmodule
