`timescale 1ns / 1ps

module shift_reg(clk, rst, SR, SL, LD, L_in, R_in, D, Q);

parameter data_width=4;
input clk, rst, SR, SL, LD, L_in, R_in;
input [data_width-1:0] D;
output reg [data_width-1:0] Q;

always@(posedge clk) begin
    if(rst) begin
        Q=0;
    end else if(LD) begin
        Q=D;
    end else if(SL) begin
        Q[data_width-1:1]=Q[data_width-2:0];
        Q[0]=R_in;
    end else if(SR) begin
        Q[data_width-2:0]=Q[data_width-1:1];
        Q[data_width-1]=L_in;
    end else begin
        Q[data_width-1:0]=Q[data_width-1:0];
    end
end
endmodule
