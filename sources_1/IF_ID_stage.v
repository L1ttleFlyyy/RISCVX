`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:32:12 PM
// Design Name: 
// Module Name: IF_ID_stage
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


module IF_ID_stage(
    input clk,
    input reset,
    input stall,
    input flush,
    input [31:0] PC_IF,
    input [31:0] Instr_IF,
    output reg [31:0] PC_ID,
    output reg [31:0] Instr_ID,
    output reg WBFF
    );
    
    always@(posedge clk or posedge reset) begin
        if (~stall) begin
            PC_ID <= PC_IF;
            Instr_ID <= Instr_IF;
        end
        if (reset) begin
            WBFF <= 1;
        end else begin
            if (flush) begin
                WBFF <= 1;
            end else begin
                WBFF <= 0;
            end
        end
    end

endmodule
