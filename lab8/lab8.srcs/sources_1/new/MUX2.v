`timescale 1ns / 1ps

module mux2(d0, d1, sel, out);
parameter data_width=4;
input sel;
input [data_width-1:0] d0;
input [data_width-1:0] d1;
output reg [data_width-1:0] out;

always@(d0, d1, sel) begin
    if(sel) begin
        out=d1;
    end else begin
        out=d0;
    end
end
endmodule
