`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 01:37:27
// Design Name: 
// Module Name: memory
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

module memory (
    input clk,
    input reset,
    input we,
    input [7:0] rd_a,
    output reg [7:0] rd_d,
    input fetch,
    input [7:0] wr_a,
    input [7:0] wr_d
);

reg [7:0] m [0:511];
integer i;

// reset + writes
always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < 256; i = i + 1)
            m[i] <= 8'd0;
/*sum_of_n*/
//        m[256] <= 8'hc7;
//        m[257] <= 8'h00;
//        m[258] <= 8'h81;
//        m[259] <= 8'hc7;
//        m[260] <= 8'h0a;
//        m[261] <= 8'h80;
//        m[262] <= 8'hd2;
//        m[263] <= 8'h11;
//        m[264] <= 8'h71;
//        m[265] <= 8'h00;
//        m[266] <= 8'h81;
//        m[267] <= 8'h70;
//        m[268] <= 8'hc1;
//        m[269] <= 8'h01;
//        m[270] <= 8'h80;
//        m[271] <= 8'hd0;
//        m[272] <= 8'h06;
//        m[273] <= 8'h71;
//        m[274] <= 8'hff;

/* fibonacci*/
//m[9'd256] <= 8'hc7;  
//m[9'd257] <= 8'h00;
//m[9'd258] <= 8'h80;  
//m[9'd259] <= 8'hc7;  
//m[9'd260] <= 8'h01;
//m[9'd261] <= 8'h81; 
//m[9'd262] <= 8'h83;  
//m[9'd263] <= 8'hf0;
////m[9'd264] <= 8'h0a;  
//m[9'd264] <= 8'h82; 

//m[9'd265] <= 8'hd2;  
//m[9'd266] <= 8'h18;  
//m[9'd267] <= 8'h71;  

//m[9'd268] <= 8'h83;  
//m[9'd269] <= 8'h00;  
//m[9'd270] <= 8'hf1;
//m[9'd271] <= 8'h81;  
//m[9'd272] <= 8'h73;  

//m[9'd273] <= 8'h80;  
//m[9'd274] <= 8'h72;  
//m[9'd275] <= 8'hc1;
//m[9'd276] <= 8'h01;  
//m[9'd277] <= 8'h82; 

//m[9'd278] <= 8'hd0;  
//m[9'd279] <= 8'h09;  

//m[9'd280] <= 8'hff;  // exit

/*factorial*/
m[9'd256] <= 8'hf0;  
m[9'd257] <= 8'h81;
m[9'd258] <= 8'h83;  
m[9'd259] <= 8'hc1;  
m[9'd260] <= 8'h02;
m[9'd261] <= 8'h82; 
m[9'd262] <= 8'h80;  
m[9'd263] <= 8'hd2;
//m[9'd264] <= 8'h0a;  
m[9'd264] <= 8'h1e; 

m[9'd265] <= 8'hd2;  
m[9'd266] <= 8'h14;  
m[9'd267] <= 8'h71;  

m[9'd268] <= 8'h03;  
m[9'd269] <= 8'h81;  
m[9'd270] <= 8'h70;
m[9'd271] <= 8'hc1;  
m[9'd272] <= 8'h01;  

m[9'd273] <= 8'h80;  
m[9'd274] <= 8'hd0;  
m[9'd275] <= 8'h09;
m[9'd276] <= 8'h71;  
m[9'd277] <= 8'h83; 

m[9'd278] <= 8'hf1;  
m[9'd279] <= 8'h72;  

m[9'd280] <= 8'hc1;  
m[9'd281] <= 8'h01;
m[9'd282] <= 8'h82;
m[9'd283] <= 8'h80;
m[9'd284] <= 8'hd0;
m[9'd285] <= 8'h07;
m[9'd286] <= 8'hff; // exit


        
    end
    else if (!fetch && we) begin
        m[wr_a] <= wr_d;
    end
end

// combinational read
always @(*) begin
    if (fetch)
        rd_d = m[{fetch, rd_a}];
    else
        rd_d = m[rd_a];
end

endmodule


