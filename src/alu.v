`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2026 00:27:15
// Design Name: 
// Module Name: alu
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


module alu(
input [7:0]A,
input [7:0]op,
input [2:0]f,
input carry_in,
output reg [7:0]result,
output zero,
output reg carry_out

    );
always@(*) begin
    carry_out=0;
    
    case(f)
        3'b000 : {carry_out, result} = A + op;      //Add
        3'b001 : {carry_out, result} = A - op;      //sub
        3'b010 : {carry_out, result} = A +op +carry_in; //abcx
        3'b011 : {carry_out, result} = A -op -carry_in; //sbb
        3'b100 : result = A&op;
        3'b101 : result = A|op;

        3'b110 : result = A^op;
        3'b111 : result = op;
    endcase
end

assign zero = (result==8'b0);


endmodule
