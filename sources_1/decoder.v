`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/12 00:17:46
// Design Name: 
// Module Name: decoder
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


module decoder#(
    parameter input_width = 2,
    parameter output_width = 2**input_width
    )(
    input [input_width - 1:0] data_in,
    output [output_width - 1:0] data_out
    );
    genvar i;
    generate
        for (i=0;i<output_width;i=i+1) begin: one_hot
                assign data_out[i] = (data_in==i);
        end
    endgenerate
    
endmodule
