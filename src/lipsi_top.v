`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2026 01:59:57
// Design Name: 
// Module Name: lipsi_top
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

module lipsi_top (
    input clk,
    input reset,
//    output [7:0] A_out,
//    output [7:0] pc_dbg,
//    output [7:0] mem_dbg,
//    output [7:0] sum_dbg,
    input  [7:0] io_in,
    output [7:0] io_out,
    output [3:0] an,
output [6:0] seg
);
wire clk_1hz;
clk_divider c0(.clk_100Mhz(clk),.clk_1hz(clk_1hz),.reset(reset));

wire fetch, we, pc_enable, acc_enable;
wire [7:0] next_pc, wr_a, wr_d, rd_a, rd_d, acc_in;
wire [7:0] A, pc_out;
reg [7:0] io_out_reg;
assign io_out = io_out_reg;

wire io_we;

always @(posedge clk_1hz or posedge reset) begin
    if (reset)
        io_out_reg <= 8'd0;
    else if (io_we)
        io_out_reg <= A;
end

control_unit cu (
    .clk(clk_1hz),
    .reset(reset),
    .rd_d(rd_d),
    .A(A),
    .pc_out(pc_out),
    .fetch(fetch),
    .we(we),
    .pc_enable(pc_enable),
    .acc_enable(acc_enable),
    .next_pc(next_pc),
    .wr_a(wr_a),
    .wr_d(wr_d),
    .rd_a(rd_a),
    .acc_in(acc_in),
    .io_in(io_in),
    .io_we(io_we)

);

pc pc0 (
    .clk(clk_1hz),
    .reset(reset),
    .enable(pc_enable),
    .next_pc(next_pc),
    .pc_out(pc_out)
);

seven_segment sev0 (
    .q(io_out_reg),
    .clk(clk),
    .reset(reset),
    .seg_ctrl(an),
    .seg_led(seg)
);

accumulator acc0 (
    .q(acc_in),
    .clk(clk_1hz),
    .reset(reset),
    .enable(acc_enable),
    .A(A)
);

memory mem0 (
    .clk(clk_1hz),
    .reset(reset),
    .we(we),
    .rd_a(rd_a),
    .rd_d(rd_d),
    .fetch(fetch),
    .wr_a(wr_a),
    .wr_d(wr_d)
);
//assign sum_dbg = mem0.m[1];
//assign A_out   = A;
//assign pc_dbg  = pc_out;
//assign mem_dbg = rd_d;

endmodule


module clk_divider(clk_100Mhz,clk_1hz,reset );
input clk_100Mhz,reset;
output reg clk_1hz;

reg [25:0]cout;

always@(posedge clk_100Mhz)
begin
if(reset)
begin
    cout<=26'd1; clk_1hz<=1'b0;
end
else
begin
    if(cout==2500000)
        begin
        cout<=26'd1; clk_1hz<=~clk_1hz;
        end

else 
    cout <= cout +26'd1;
 end   
end
endmodule