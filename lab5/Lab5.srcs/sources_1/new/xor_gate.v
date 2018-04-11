`timescale 1ns / 1ps

module xor_gate(
	input wire 	in1,
	input wire 	in2,
	output wire out
    );

	assign out = in1 ^ in2;
	
endmodule
