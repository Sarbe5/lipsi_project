`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2026 02:05:57
// Design Name: 
// Module Name: testbench
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



module tb_lipsi_top;

    reg clk;
    reg reset;
    reg [7:0] io_in;

    wire [7:0] io_out;
//    wire [7:0] A_out;
//    wire [7:0] pc_dbg;
//    wire [7:0] mem_dbg;
    wire [7:0] sum_dbg;
    wire [3:0] seg_ctrl;
    wire [6:0] seg_led;

    lipsi_top dut (
        .clk(clk),
        .reset(reset),
        .io_in(io_in),
        .io_out(io_out),
//        .A_out(A_out),
//        .pc_dbg(pc_dbg),
//        .mem_dbg(mem_dbg),
        .sum_dbg(sum_dbg),
        .an(seg_ctrl),
        .seg(seg_led)
    );

   
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    
    initial begin
        reset = 1'b1;
        io_in = 8'd5;   

        #20;
        reset = 1'b0;

        #15000;
        $finish;
    end

   
//    initial begin
//        $monitor("t=%0t reset=%b pc=%0d A=%0d io_in=%0d io_out=%0d rd_d=%h sum=%0d state=%0d ir=%h opr=%h mdr=%h",
//                 $time, reset, pc_dbg, A_out, io_in, io_out, mem_dbg, sum_dbg,
//                 dut.cu.state, dut.cu.ir, dut.cu.opr, dut.cu.mdr);
//    end

endmodule