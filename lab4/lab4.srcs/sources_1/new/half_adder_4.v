`timescale 1ns / 1ps

module half_adder_4(
	input wire [3:0] 	A,
	input wire [3:0] 	B,
	output wire [3:0] 	P,
	output wire [3:0] 	G
    );

	half_adder H1(
		.a 		(A[0]),
		.b 		(B[0]),
		.p 		(P[0]),
		.g 		(G[0])
		);
	half_adder H2(
		.a 		(A[1]),
		.b 		(B[1]),
		.p 		(P[1]),
		.g 		(G[1])
		);
	half_adder H3(
		.a 		(A[2]),
		.b 		(B[2]),
		.p 		(P[2]),
		.g 		(G[2])
		);
	half_adder H4(
		.a 		(A[3]),
		.b 		(B[3]),
		.p 		(P[3]),
		.g 		(G[3])
		);
endmodule
