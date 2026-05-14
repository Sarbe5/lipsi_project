`timescale 1ns / 1ps
module control_unit (
    input clk, reset,
    input [7:0] rd_d,A,pc_out,
    output reg fetch,we,pc_enable,acc_enable,
    output reg [7:0] next_pc, wr_a, wr_d,rd_a, acc_in,
    input  [7:0] io_in,
output reg   io_we);
localparam S_FETCH1  = 3'd0,
           S_DECODE  = 3'd1,
           S_FETCH2  = 3'd2,
           S_MEMREAD = 3'd3,
           S_EXEC    = 3'd4,
           S_EXIT    = 3'd5;
        //    S_IO      = 3'd6;

    reg [2:0] state, next_state;
    reg [7:0] ir ,opr,mdr;
    reg ir_load, opr_load, mdr_load;
// io_we = 1'b0;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S_FETCH1;
        ir    <= 8'd0;
        opr   <= 8'd0;
        mdr   <= 8'd0;
  
    end
    else begin
        state <= next_state;

        if (ir_load) ir <= rd_d;
        if (opr_load) opr <= rd_d;
        if (mdr_load) mdr <= rd_d;     
          end
end

always@(*) begin 
    case(state)
        S_FETCH1: 
        begin
            next_state = S_DECODE;
        end
        S_DECODE: begin
            if(ir == 8'hff) 
                next_state = S_EXIT;
            else if (ir[7:4] == 4'b1111)
                next_state = S_EXEC;
            else if(ir[7:4] == 4'b1100 || ir[7:4] == 4'b1101) // c7, c1 // d0,d2

                next_state = S_FETCH2;
            else if(ir[7:4] == 4'b1000)                      // 80,81
                next_state = S_EXEC;
            else if(ir[7]==1'b0)                             // 70 ,71,00
                next_state = S_MEMREAD;
            else
                next_state = S_EXIT;
            
        end
                S_FETCH2: begin
            next_state = S_EXEC;
        end

        S_MEMREAD: begin
            next_state = S_EXEC;
        end

        S_EXEC: begin
            next_state = S_FETCH1;
        end

        S_EXIT: begin
            next_state = S_EXIT;
        end

        default: begin
            next_state = S_FETCH1;
        end
    endcase


end

always@(*) begin
ir_load=1'b0;
opr_load=1'b0;
mdr_load=1'b0;
    
case(state)
S_FETCH1: begin
            ir_load=1'b1   ;      
end
S_FETCH2: begin
            opr_load=1'b1; 
end
S_MEMREAD: begin
            mdr_load=1'b1; 
end
default: begin
    ir_load  = 1'b0;
    opr_load = 1'b0;
    mdr_load = 1'b0;
end

endcase
end

always@(*) begin
fetch = 1'b0;
we = 1'b0;
pc_enable= 1'b0;
acc_enable = 1'b0;
io_we = 1'b0;
    acc_in = A;
next_pc = pc_out;
rd_a = 8'b0;
wr_a = 8'b0;
wr_d = 8'b0;

case(state)
    S_FETCH1: begin
        fetch = 1'b1;
        rd_a = pc_out;
    end
    S_FETCH2: begin
        fetch = 1'b1;
        rd_a = pc_out+8'b1;

    end
    S_MEMREAD: begin
        fetch = 1'b0;
        rd_a = {4'b0000,ir[3:0]};
    end
    S_EXEC: begin
        if (ir[7:4] == 4'b1000) begin  // 80,81
            fetch = 1'b0;
            we = 1'b1;
            wr_a = {4'b0000,ir[3:0]};
            wr_d = A;
            pc_enable = 1'b1;
            next_pc = pc_out + 8'b1;
        end
        else if (ir == 8'hf0) begin
            acc_enable = 1'b1;
            pc_enable  = 1'b1;
            acc_in     = io_in;
            next_pc    = pc_out + 8'd1;
        end
        else if (ir == 8'hf1) begin
            io_we      = 1'b1;
            pc_enable  = 1'b1;
            next_pc    = pc_out + 8'd1;
        end
        else if (ir[7] == 1'b0) begin
            acc_enable = 1'b1;
            pc_enable  = 1'b1;
            next_pc    = pc_out + 8'd1;

            case (ir[6:4])
                3'b111: acc_in = mdr;       // ld rx
                3'b000: acc_in = A + mdr;   // add rx
                default: begin
                    acc_enable = 1'b0;
                    pc_enable  = 1'b0;
                end
            endcase
        end
        else if (ir == 8'h00) begin      //00
            acc_enable = 1'b1;
            pc_enable = 1'b1;
            acc_in = A+mdr;
            next_pc = pc_out +8'b1;
        end
        else if (ir[7:4] == 4'b1100) begin  // c7, c1
            acc_enable = 1'b1;
            pc_enable = 1'b1;
            next_pc = pc_out +8'd2;

            if (ir == 8'hc7) acc_in = opr;
            else if (ir == 8'hc1) acc_in = A-opr;
        end
        else if (ir[7:4] == 4'b1101) begin   // d0,d2
            pc_enable =1'b1;
            if (ir == 8'hd0) next_pc = opr;
            else if (ir == 8'hd2) begin
                if(A==8'd0)
                next_pc = opr;
                else next_pc = pc_out + 8'd2;
            end
        end
    
    end
    S_EXIT: begin
        // fetch = 1'b0;
        // we = 1'b0;
        // pc_enable = 1'b0;
        // acc_enable = 1'b0;
    end

endcase
end



endmodule