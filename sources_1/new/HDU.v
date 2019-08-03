`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:32:12 PM
// Design Name: 
// Module Name: HDU
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


module HDU(
    input [4:0] rs1_ID,
    input [4:0] rs2_ID,
    input rs1_valid,
    input rs2_valid,
    input [4:0] rd_EX,
    input memread_EX,
    input regwrite_EX,
    output stall
    );
    
    assign stall = 
    ( memread_EX && regwrite_EX && rs1_valid && (rs1_ID == rd_EX) )
    ||
    ( memread_EX && regwrite_EX && rs2_valid && (rs2_ID == rd_EX) );

endmodule
