`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:32:12 PM
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    input clk,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input regwrite,
    input [31:0] rd_data,
    output [31:0] rs1_data,
    output [31:0] rs2_data
    );

    reg [31:0] regs [1:31];
    assign rs1_data = (rs1 == 5'b0)? 32'b0 : ((rd == rs1) && regwrite) ? rd_data : regs[rs1];
    assign rs2_data = (rs2 == 5'b0)? 32'b0 : ((rd == rs2) && regwrite) ? rd_data : regs[rs2];

    always@(posedge clk) begin
        if (regwrite)
            regs[rd] <= rd_data;
    end

endmodule
