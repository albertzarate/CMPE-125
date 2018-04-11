`timescale 1ns / 1ps

module cla_adder(
	input wire [3:0] 	A,
	input wire [3:0] 	B,
	input wire 		 	carry,
	output wire [3:0] 	sum,
	output wire 		cout
    );

wire [3:0] P;
wire [3:0] G;
wire [4:0] C;


half_adder_4 HA4(
    .A 		(A),
    .B 		(B),
    .P 		(P),
    .G 		(G)
    );

cla_gen CLA(
    .P 		(P),
    .G 		(G),
    .carry 	(carry),
    .C 		(C)
    );

xor_gate_4 XOR4(
    .P		(P),
    .C 		({C[3:1], carry}),
    .sum 	(sum)
    );
    
assign cout = C[4];

endmodule
