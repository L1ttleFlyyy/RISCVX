`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/11 20:28:35
// Design Name: 
// Module Name: softrisc_top
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


module softrisc_top(
    input clk,
    input btnC,
    input btnU,
    input btnD,
    input btnR,
    input btnL,
    input [15:0] sw,
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [15:0] led
    );
    wire rst;
    wire clk_1;
    wire [7:0] dataA, dataB;
    wire [3:0] bcdn[0:3];
    assign dataA = sw[7:0];
    assign dataB = sw[15:8];
    assign led = sw;
    assign rst = ~btnC;
    
    Adder32(
        .A({dataA,dataA,dataA,dataA}),
        .B({dataB,dataB,dataB,dataB}),
        .CI(0),
        .S({bcdn[3],bcdn[2],bcdn[1],bcdn[0]})
    );
    
    seg_scan(
        .clk(clk),
        .rst(rst),
        .bcd3(bcdn[3]),
        .bcd2(bcdn[2]),
        .bcd1(bcdn[1]),
        .bcd0(bcdn[0]),
        .an(an),
        .seg(seg),
        .dp(dp)
    );
endmodule
