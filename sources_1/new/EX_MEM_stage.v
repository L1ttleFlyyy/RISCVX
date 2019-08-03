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

    input memread_EX,
    input memwrite_EX,
    input regwrite_EX,
    input [4:0] rd_EX,
    input [31:0] ALU_data_EX,

    output reg memread_MEM,
    output reg memwrite_MEM,
    output reg regwrite_MEM,
    output reg [4:0] rd_MEM,
    output reg [31:0] ALU_data_MEM
    );
    
    always@(posedge clk or posedge reset) begin
        if (reset) begin
            memread_MEM <= 0;
            memwrite_MEM <= 0;
            regwrite_MEM <= 0;
        end else begin
            memread_MEM <= memread_EX;
            memwrite_MEM <= memwrite_EX;
            regwrite_MEM <= regwrite_EX;
            rd_MEM <= rd_EX;
            ALU_data_MEM <= ALU_data_EX;
        end
    end

endmodule
