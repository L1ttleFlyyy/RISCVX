`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:32:12 PM
// Design Name: 
// Module Name: MEM_WB_stage
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


module MEM_WB_stage(
    input clk,
    input reset,

    input regwrite_MEM,
    input [4:0] rd_MEM,
    input [31:0] rd_data_MEM

    output reg regwrite_WB,
    output reg [4:0] rd_WB,
    output reg [31:0] rd_data_WB
    );
    
    always@(posedge clk or posedge reset) begin
        if (reset) begin
            regwrite_WB <= 0;
        end else begin
            rd_WB <= rd_MEM;
            regwrite_WB <= regwrite_MEM;
            rd_data_WB <= rd_data_MEM;
        end
    end

endmodule
