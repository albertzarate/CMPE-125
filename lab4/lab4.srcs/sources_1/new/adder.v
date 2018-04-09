`timescale 1ns / 1ps

module adder(
    input  wire carry,
	input  wire [3:0] A,
	input  wire [3:0] B,
	output wire [3:0] sum,
	output wire cout
    );


	// always @ (A, B) begin
	// 	{carry, sum} = A + B;
	// end

	assign {cout, sum} = A + B + carry;

endmodule
