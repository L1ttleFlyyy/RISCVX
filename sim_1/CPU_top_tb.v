`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2019 11:27:16 PM
// Design Name: 
// Module Name: CPU_top_tb
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


module CPU_top_tb(

    );
    
    reg clk,reset;
    
    initial begin
        clk = 0;
        reset = 1;
        #32;
        reset = 0;
    end
    
    always begin
        clk = ~clk;
        #5;
    end
    
CPU_top uut(
        .clk(clk),
        .reset(reset),
        .data_in(32'b0),
        .addr_in(32'h3),
        .cmd(2'b00),
        .data_out()
        );
endmodule
