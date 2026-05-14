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

    wire [7:0] A_out;
    wire [7:0] pc_dbg;
    wire [7:0] mem_dbg;
    wire [7:0] sum_dbg;
    

    lipsi_top dut (
        .clk(clk),
        .reset(reset),
        .A_out(A_out),
        .pc_dbg(pc_dbg),
        .mem_dbg(mem_dbg),
        .sum_dbg(sum_dbg)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1'b1;
        #12;
        reset = 1'b0;

        #15000;
        $finish;
    end

    initial begin
        $monitor("t=%0t reset=%b pc=%0d A=%0d mem_dbg=%h sum_dbg=%0d state=%0d rd_d=%h ir=%h opr=%h mdr=%h fetch=%b we=%b",
                 $time, reset, pc_dbg, A_out, mem_dbg,sum_dbg,
                 dut.cu.state, dut.cu.rd_d, dut.cu.ir, dut.cu.opr, dut.cu.mdr,
                 dut.cu.fetch, dut.cu.we);
    end


endmodule