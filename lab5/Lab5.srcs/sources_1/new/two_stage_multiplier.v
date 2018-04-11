`timescale 1ns / 1ps

module two_stage_multiplier(
    input wire [3:0] A,
	input wire [3:0] B,
	input clk100MHz, 
    input rst,
    output wire [7:0] preg
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
    wire [7:0] P;
    
    wire [3:0] dreg1;
    wire [3:0] dreg2;
    wire [7:0] sreg1;
    wire [7:0] sreg2;    
    
    
    param_D_reg #(4) DR1(
        .clk    (clk100MHz),
        .reset  (rst),
        .en     (1'b1),
        .d      (A),
        .q      (dreg1)    
        );
    
    param_D_reg #(4) DR2(
        .clk    (clk100MHz),
        .reset  (rst),
        .en     (1'b1),
        .d      (B),
        .q      (dreg2)    
        );

    PP PLYR1(
        .A      (dreg1),
        .b      (dreg2[0]),
        .out    (out0)
        );
    PP PLYR2(
        .A      (dreg1),
        .b      (dreg2[1]),
        .out    (out1)
        );
    PP PLYR3(
        .A      (dreg1),
        .b      (dreg2[2]),
        .out    (out2)
        );
    PP PLYR4(
        .A      (dreg1),
        .b      (dreg2[3]),
        .out    (out3)
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

	param_D_reg SR1(
        .clk    (clk100MHz),
        .reset  (rst),
        .en     (1'b1),
        .d      (P1),
        .q      (sreg1)    
        );
    
    param_D_reg SR2(
        .clk    (clk100MHz),
        .reset  (rst),
        .en     (1'b1),
        .d      (P2),
        .q      (sreg2)    
        );

    cla_adder_8bit CLA3(
		.PP0 	(sreg1),
		.PP1 	(sreg2),
		.P 	 	(P)
		);

    param_D_reg PR(
        .clk    (clk100MHz),
        .reset  (rst),
        .en     (1'b1),
        .d      (P),
        .q      (preg)    
        );
    
endmodule
