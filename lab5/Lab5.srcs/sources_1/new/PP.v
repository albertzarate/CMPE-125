`timescale 1ns / 1ps

module PP(
	input wire [3:0]   A,
	input wire         b,
	output wire [3:0]  out
    );

    assign out[0] = A[0] & b;
    assign out[1] = A[1] & b;
    assign out[2] = A[2] & b;
    assign out[3] = A[3] & b;

endmodule