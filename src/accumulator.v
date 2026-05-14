`timescale 1ns / 1ps
module accumulator (input [7:0] q ,input clk, input reset , output reg [7:0] A,input enable);

always@(posedge clk)
begin
if(reset)
A<=0;
else if(enable)
A<=q;
end

endmodule


//module pc(
//    input clk,
//    input reset,
//    input enable,
//    input [7:0] next_pc,
//    output reg [7:0] pc_out
//);

//always @(posedge clk) begin
//    if (reset)
//        pc_out <= 8'd0;
//    else if (enable)
//        pc_out <= next_pc;
//end

//endmodule



//module pc_adder(input [7:0] cin, output [7:0] cout);
//assign cout = cin +1 ;
//endmodule


//module memory (input clk, reset, we, input [7:0] rd_a, output reg  [7:0] rd_d, input fetch,
//    input [7:0]  wr_a,
//    input [7:0] wr_d );

//reg [7:0] m [511:0] ;
//integer i ;

//always @(posedge clk)
//begin

//if(reset)
//begin

//for(i=0;i<256;i=i+1) begin
//m[i]<= 0 ;
//end

//m[9'd256] <= 8'hc7;
//        m[9'd257] <= 8'h00;
//        m[9'd258] <= 8'h81;
//        m[9'd259] <= 8'hc7;
//        m[9'd260] <= 8'h05;
//        m[9'd261] <= 8'h80;
//        m[9'd262] <= 8'hd2;
//        m[9'd263] <= 8'h11;
//        m[9'd264] <= 8'h71;
//        m[9'd265] <= 8'h00;
//        m[9'd266] <= 8'h81;
//        m[9'd267] <= 8'h70;
//        m[9'd268] <= 8'hc1;
//        m[9'd269] <= 8'h01;
//        m[9'd270] <= 8'h80;
//        m[9'd271] <= 8'hd0;
//        m[9'd272] <= 8'h06;
//m[9'd273] <= 8'h71;
//m[9'd274] <= 8'hff;
   
//// rd_d <= m[9'd256];

//end

//else
//begin
//if(fetch)
//begin
//rd_d<=m[{fetch,rd_a}];
//end

//else
//begin
//if(we)
//m[wr_a] <= wr_d;

//else
//rd_d<=m[rd_a];

//end

//end
//end
//endmodule







