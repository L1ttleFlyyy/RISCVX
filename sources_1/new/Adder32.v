`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:57:24 PM
// Design Name: 
// Module Name: Adder32
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


module Adder32(
    input [31:0] A,
    input [31:0] B,
    input CI,
    output [31:0] S
    );
    wire Gmm;
    wire Pmm;
    wire C1 = Gmm + Pmm*CI;
    Adder16 adder16_0 (A[15:0], B[15:0], CI, Gmm, Pmm, S[15:0]);
    Adder16 adder16_1 (.A(A[31:16]), .B(B[31:16]), .CI(C1), .Gmm(), .Pmm(), .S(S[31:16]));

endmodule

module Adder16(
    input [15:0] A,
    input [15:0] B,
    input CI,
    output Gmm,
    output Pmm,
    output [15:0] S
);
    wire [3:0] Gm;
    wire [3:0] Pm;
    wire [3:1] C;
    Adder4 adder4_0 (A[3:0], B[3:0], CI, Gm[0], Pm[0], S[3:0]);
    Adder4 adder4_0 (A[7:4], B[7:4], C[1], Gm[1], Pm[1], S[7:4]);
    Adder4 adder4_0 (A[11:8], B[11:8], C[2], Gm[2], Pm[2], S[11:8]);
    Adder4 adder4_0 (A[15:12], B[15:12], C[3], Gm[3], Pm[3], S[15:12]);
    CLA4 cla4_0(Pm, Gm, CI, Gmm, Pmm, C);

endmodule

module Adder4(
    input [3:0] A,
    input [3:0] B,
    input CI,
    output Gm,
    output Pm,
    output [3:0] S
);
    wire [3:0] G;
    wire [3:0] P;
    wire [3:1] C;

    Adder1 adder1_0 (A[0],B[0],CI,G[0],P[0],S[0]);
    Adder1 adder1_1 (A[1],B[1],C[1],G[1],P[1],S[1]);
    Adder1 adder1_2 (A[2],B[2],C[2],G[2],P[2],S[2]);
    Adder1 adder1_3 (A[3],B[3],C[3],G[3],P[3],S[3]);

    CLA4 cla4_0(P, G, CI, Gm, Pm, C);

endmodule

module Adder1(
    input A,
    input B,
    input CI,
    output G,
    output P,
    output S
);
    assign G = A * B;
    assign P = A + B;
    assign S = A ^ B ^ CI;
endmodule

module CLA4(
    input [3:0] P,
    input [3:0] G,
    input CI,
    output Gm,
    output Pm,
    output [3:1] CO
);
    assign CO[1] = G[0] + P[0]*CI;
    assign CO[2] = G[1] + P[1]*CO[1];
    assign CO[3] = G[2] + P[2]*CO[2];
    assign Gm = G[3] + P[3]*G[2] + P[3]*P[2]*G[1] + P[3]*P[2]*P[1]*G[0];
    assign Pm = &P;
endmodule
