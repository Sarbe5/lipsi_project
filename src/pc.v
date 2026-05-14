`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2026 01:57:45
// Design Name: 
// Module Name: pc
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

module pc(
    input clk,
    input reset,
    input enable,
    input [7:0] next_pc,
    output reg [7:0] pc_out
);

always @(posedge clk) begin
    if (reset)
        pc_out <= 8'd0;
    else if (enable)
        pc_out <= next_pc;
end

endmodule

