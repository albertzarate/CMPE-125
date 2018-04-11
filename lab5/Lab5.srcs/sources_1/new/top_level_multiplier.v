`timescale 1ns / 1ps

module top_level_multiplier(
	input wire [3:0] A,
	input wire [3:0] B,
	output wire [7:0] P
    );

    wire [3:0] out0;
    wire [3:0] out1;
    wire [3:0] out2;
    wire [3:0] out3;
    wire [7:0] PP0;
    wire [7:0] PP1;
    wire [7:0] PP2;
    wire [7:0] PP3;
    
	wire [7:0] P1;
	wire [7:0] P2;


	PP PLYR1(
        .A      (A),
        .b      (B[0]),
        .out     (out0)
        );
    PP PLYR2(
        .A      (A),
        .b      (B[1]),
        .out     (out1)
        );
    PP PLYR3(
        .A      (A),
        .b      (B[2]),
        .out     (out2)
        );
    PP PLYR4(
        .A      (A),
        .b      (B[3]),
        .out     (out3)
        );
        
     assign PP0 = out0;   
     assign PP1 = out1<<1;
     assign PP2 = out2<<2;
     assign PP3 = out3<<3;
        
        
	cla_adder_8bit CLA1(
		.PP0 	(PP0),
		.PP1 	(PP1),
		.P 	 	(P1)
		);

	cla_adder_8bit CLA2(
		.PP0 	(PP2),
		.PP1 	(PP3),
		.P 	 	(P2)
		);

	cla_adder_8bit CLA3(
		.PP0 	(P1),
		.PP1 	(P2),
		.P 	 	(P)
		);
endmodule
