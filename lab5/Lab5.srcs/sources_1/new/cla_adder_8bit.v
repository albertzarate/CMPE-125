`timescale 1ns / 1ps

module cla_adder_8bit(
	input wire [7:0] PP0,
	input wire [7:0] PP1,
	output wire [7:0] P 
	//output wire 	  cout
	);

    wire carry;
    
	cla_adder ADD1(
		.A 		(PP0[3:0]),
		.B 		(PP1[3:0]),
		.carry 	(1'b0),
		.sum 	(P[3:0]),
		.cout 	(carry)
		);
	cla_adder ADD2(
		.A 		(PP0[7:4]),
		.B 		(PP1[7:4]),
		.carry 	(carry),
		.sum 	(P[7:4])
		);
		
endmodule // cla_adder_8bit

