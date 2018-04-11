`timescale 1ns / 1ps

module cla_gen(
	input wire [3:0] 	P,
	input wire [3:0] 	G,
	input wire 		 	carry,
	output wire [4:0] 	C
    );
    
	assign C[1] = G[0] | (P[0] & carry);
	assign C[2] = G[1] | (P[1] & (G[0] | (P[0] & carry)));							
	assign C[3] = G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & carry)))));
	assign C[4] = G[3] | (P[3] & (G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & carry)))))));
    assign C[0] = 0;
endmodule
