`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2019 06:32:12 PM
// Design Name: 
// Module Name: LoadMask
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


module LoadMask(
    input [31:0] mem_data_raw,
    input [1:0] addr,
    input [2:0] funct3,
    output reg [31:0] mem_data
    );

    wire [7:0] byte_data = 
        (addr == 2'b00)? mem_data_raw[7:0] :
        (addr == 2'b01)? mem_data_raw[15:8] :
        (addr == 2'b10)? mem_data_raw[23:16] : mem_data_raw[31:24];
    wire [15:0] half_data = addr[1] ? mem_data_raw[31:16] : mem_data_raw[15:0];

    always@ (*) begin
        case (funct3)
            3'b000: mem_data = {{24{byte_data[7]}}, byte_data};
            3'b001: mem_data = {{16{half_data[15]}}, half_data};
            3'b100: mem_data = {24'b0, byte_data};
            3'b101: mem_data = {16'b0, half_data};
            default: mem_data = mem_data_raw;
        endcase
    end

endmodule
