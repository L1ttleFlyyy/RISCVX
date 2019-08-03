`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 08:55:00 PM
// Design Name: 
// Module Name: Adder32_tb
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


module Adder32_tb(

    );

    reg [31:0] A, B;
    reg CI;
    wire [31:0] S;

    Adder32 uut(A, B, CI, S);

    initial begin
        A = 0;
        B = 0;
        CI = 0;
        #10;
        A = 32'h1;
        B = 32'h1;
        #10;
        A = 32'h7fffffff;
        B = 32'h7fffffff;
        #10;
        A = 32'h80000000;
        #10;
        B = 32'h80000000;
        #10;
        A = 32'hffffffff;
        B = 32'h1;
    end

    always begin
        #5;
        CI = ~CI;
    end

endmodule
