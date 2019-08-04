`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:32:12 PM
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter(
    input clk,
    input reset,
    input stall,
    input j_br,
    input [31:0]bta,
    output reg [31:0] PC_IF,
    output [31:0] PC_next
    );

    assign PC_next = j_br? bta : (stall||reset)? PC_IF : (PC_IF+4);

    always@(posedge clk or posedge reset) begin
        if (reset) begin
            PC_IF <= 32'b0;
        end else begin
            PC_IF <= PC_next;
        end
    end

endmodule
