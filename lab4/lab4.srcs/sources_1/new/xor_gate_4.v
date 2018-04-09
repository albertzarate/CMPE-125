`timescale 1ns / 1ps

module xor_gate_4(
	input wire [3:0] 	P,
	input wire [3:0] 	C,
	output wire [3:0] 	sum
    );

	xor_gate X1(
		.in1	(P[0]),
		.in2	(C[0]),
		.out 	(sum[0])
		);

	xor_gate X2(
		.in1 	(P[1]),
		.in2 	(C[1]),
		.out 	(sum[1])
		);

	xor_gate X3(
		.in1 	(P[2]),
		.in2 	(C[2]),
		.out 	(sum[2])
		);

	xor_gate X4(
		.in1 	(P[3]),
		.in2 	(C[3]),
		.out 	(sum[3])
		);
endmodule
