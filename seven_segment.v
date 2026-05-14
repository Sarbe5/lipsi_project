`timescale 1ns / 1ps
module seven_segment(
    input [7:0] q,
    input clk,
    input reset,
    output reg [3:0] seg_ctrl,
    output reg [6:0] seg_led
);

reg [15:0] refresh_counter;
reg select;
reg [3:0] digit;

always@(posedge clk) begin
    if(reset) begin
        refresh_counter <= 0;
        select <=0;
    end
    else begin
        refresh_counter<=refresh_counter+16'd1;
        if(refresh_counter == 16'd0)
        begin
            select<=~select;
        end
    end
end


always@(*) begin
    case(select)
    1'b0: begin
        digit =q[3:0];
        seg_ctrl = 4'b1110;
    end
    1'b1: begin
        digit =q[7:4];
        seg_ctrl = 4'b1101;
    end
    default: begin
    digit = 4'h0;
    seg_ctrl = 4'b1111;
end
    endcase
end



always @(*) begin
    case (digit)
        4'h0: seg_led = 7'b1000000;
        4'h1: seg_led = 7'b1111001;
        4'h2: seg_led = 7'b0100100;
        4'h3: seg_led = 7'b0110000;
        4'h4: seg_led = 7'b0011001;
        4'h5: seg_led = 7'b0010010;
        4'h6: seg_led = 7'b0000010;
        4'h7: seg_led = 7'b1111000;
        4'h8: seg_led = 7'b0000000;
        4'h9: seg_led = 7'b0010000;
        4'hA: seg_led = 7'b0001000;
        4'hB: seg_led = 7'b0000011;
        4'hC: seg_led = 7'b1000110;
        4'hD: seg_led = 7'b0100001;
        4'hE: seg_led = 7'b0000110;
        4'hF: seg_led = 7'b0001110;
        default: seg_led = 7'b1111111;
    endcase
end




endmodule