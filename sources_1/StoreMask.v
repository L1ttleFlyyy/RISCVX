`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:32:12 PM
// Design Name: 
// Module Name: StoreMask
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


module StoreMask(
    input memwrite,
    input [1:0] addr,
    input [2:0] funct3,
    output [3:0] mask
    );

    wire [3:0] mask_Byte;
    wire [3:0] mask_Half = addr[1]? 4'b1100 : 4'b0011;
    decoder d2_4(.data_in(addr), .data_out(mask_Byte));

    assign mask = memwrite ? (
        (funct3 == 3'b000) ? mask_Byte : //byte
        (funct3 == 3'b001) ? mask_Half : //half
        4'b1111) : 4'b0000; // word

endmodule
