`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/11 22:45:35
// Design Name: 
// Module Name: clock_gen
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
`define SYSCLK 1e8

module clock_gen#(
    parameter clk_fre = 1e3
) (
    input clk,
    input rst,
    output reg clk_out
);

    localparam integer cnt = $floor(`SYSCLK/clk_fre) - 1;
    localparam width = $clog2(cnt);
    
    reg [width-1:0] counter; 

    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            clk_out <= 0;
            counter <= 0;
        end else begin
            if(counter == cnt) begin
                clk_out <= 1;
                counter <= 0;
            end else begin
                clk_out <= 0;
                counter <= counter + 1;
            end
        end
    end

endmodule
