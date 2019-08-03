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
    input HDU_stall,
    input br,
    input [31:0]bta,
    input j,
    input [31:0]ja,
    output [31:0] PC_next
    );

    assign PC_next = j? ja : br? bta : HDU_stall? PC : (PC+4);

    reg[31:0] PC;
    always@(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 32'b0;
        end else begin
            PC <= PC_next;
        end
    end

endmodule
