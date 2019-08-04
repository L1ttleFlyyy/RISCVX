`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:57:24 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] rs1_data,
    input [31:0] rs2_data,
    input [31:0] PC,
    input [31:0] imm,
    input [2:0] ALUOP,
    input Asrc,
    input Bsrc,
    input sra,
    input shdir,
    input sub,
    input jalr,
    output [31:0] BTA,
    output EQ,
    output LT,
    output LTU,
    output reg[31:0] Z
    );
    
    wire [31:0] A_in_PC, B_in_PC, A_in, B_in, Z_add_sub, Z_shift, Z_and, Z_or, Z_xor, Z_slt, Z_sltu;
    assign EQ = A_in == B_in;
    assign LT = $signed(A_in) <= $signed(B_in);
    assign LTU = A_in <= B_in;
    assign A_in = Asrc? PC : rs1_data;
    assign B_in = jalr? 32'h4 : Bsrc? imm : rs2_data;
    assign Z_add_sub = sub? (A_in + B_in) : (A_in - B_in);
    assign Z_shift = shdir? (rs1_data << B_in[4:0]) : sra? (rs1_data >>> B_in[4:0]) : (rs1_data >> B_in[4:0]);
    assign Z_and = A_in & B_in;
    assign Z_or = A_in | B_in;
    assign Z_xor = A_in ^ B_in;
    assign Z_slt = LT? 32'b1 : 32'b0;
    assign Z_sltu = LTU? 32'b1 : 32'b0;
    
    // branch target adder
    assign A_in_PC = jalr? rs1_data : PC;
    assign B_in_PC = imm;
    assign BTA = A_in_PC + B_in_PC;

    always@(*)begin
        case (ALUOP)
            3'b000: Z = Z_add_sub;
            3'b001: Z = Z_shift;
            3'b010: Z = Z_slt;
            3'b011: Z = Z_sltu;
            3'b100: Z = Z_xor;
            3'b101: Z = Z_shift; 
            3'b110: Z = Z_or;
            3'b111: Z = Z_and;
        endcase 
    end
    
endmodule
