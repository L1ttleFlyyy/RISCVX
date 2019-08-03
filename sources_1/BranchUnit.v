`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:57:24 PM
// Design Name: 
// Module Name: BranchUnit
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


module BranchUnit(
    input j,
    input br,
    input [2:0] funct3,
    input EQ,
    input LT,
    input LTU,
    output reg j_br
    );

    always@ (*) begin
        j_br = 0;
        if (j) 
            j_br = 1;
        else if (br) begin
            case (funct3)
                3'b000: j_br = EQ; //BEQ
                3'b001: j_br = ~EQ; //BNE
                3'b100: j_br = LT; //BLT
                3'b101: j_br = ~LT; //BGE
                3'b110: j_br = LTU; //BLTU
                3'b111: j_br = ~LTU; //BGEU
                default: j_br = 0; 
            endcase 
        end

    end
    
endmodule
