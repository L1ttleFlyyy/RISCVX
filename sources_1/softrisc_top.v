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
    
    wire clk_1;
    wire [3:0] bcdn[0:3];
    reg [31:0] addr_in, data_in;
    reg [1:0] cmd;
    wire [7:0]dataA = sw[7:0];
    wire [7:0]dataB = sw[15:8];
    wire reset = btnC;
    assign led = sw;
    
    always@(posedge clk) begin
        addr_in <= {24'b0, dataA};
        data_in <= {26'b0, dataB[5:0]};
        cmd <= dataB[7:6];
    end
    
    CPU_top CPU_0(
        .clk(clk),
        .reset(btnC),
        .addr_in(addr_in),
        .data_in(data_in),
        .cmd(cmd),
        .data_out({bcdn[3],bcdn[2],bcdn[1],bcdn[0]})
    );
    
    seg_scan(
        .clk(clk),
        .reset(reset),
        .bcd3(bcdn[3]),
        .bcd2(bcdn[2]),
        .bcd1(bcdn[1]),
        .bcd0(bcdn[0]),
        .an(an),
        .seg(seg),
        .dp(dp)
    );
endmodule
