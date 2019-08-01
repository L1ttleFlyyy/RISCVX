`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/11 20:37:18
// Design Name: 
// Module Name: seg_scan
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


module seg_scan(
    input clk,
    input rst,
    input [3:0] bcd0,
    input [3:0] bcd1,
    input [3:0] bcd2,
    input [3:0] bcd3,
    output reg [3:0] an,
    output [6:0] seg,
    output dp
    );
    
    wire clk_1k;
    reg [3:0] bcd_sel;
    reg [1:0] sel;
    
    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            sel <= 0;
        end else begin
            if(clk_1k) begin
                sel <= sel + 1;
            end
        end
    end
    
    always@(sel)begin
        case(sel)
            2'h0: begin
                bcd_sel = bcd0;
                an = 4'b1110;
            end
            2'h1: begin
                bcd_sel = bcd1;
                an = 4'b1101;
            end
            2'h2: begin
                bcd_sel = bcd2;
                an = 4'b1011;
            end
            2'h3: begin
                bcd_sel = bcd3;
                an = 4'b0111;
            end
        endcase
    end
    
    clock_gen#(
        .clk_fre(1000)
        ) clock_gen_1k (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_1k)
    );
    
    bcd_to_display(
        .bcd(bcd_sel),
        .seg(seg)
    );
    assign dp = 0;
    
endmodule

module bcd_to_display(
    input [3:0] bcd,
    output reg[6:0] seg
    );
    always @(bcd) begin
        case (bcd)
            4'h0:   seg = 7'h40;
            4'h1:   seg = 7'h79;
            4'h2:   seg = 7'h24;
            4'h3:   seg = 7'h30;
            4'h4:   seg = 7'h19;
            4'h5:   seg = 7'h12;
            4'h6:   seg = 7'h02;
            4'h7:   seg = 7'h78;
            4'h8:   seg = 7'h00;
            4'h9:   seg = 7'h10;
            4'ha:   seg = 7'h08;
            4'hb:   seg = 7'h03;
            4'hc:   seg = 7'h46;
            4'hd:   seg = 7'h21;
            4'he:   seg = 7'h06;
            4'hf:   seg = 7'h0e;
        endcase
    end
endmodule
