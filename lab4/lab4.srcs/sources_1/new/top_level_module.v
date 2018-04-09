`timescale 1ns / 1ps


module top_level_module(
	input clk100MHz, 
	input rst,
	input wire [3:0]  A,
	input wire [3:0]  B,
	input wire        carry,
	output wire [3:0] A_LED,
	output wire [3:0] B_LED,
	output [7:0] LEDSEL, 
	output [7:0] LEDOUT
    );

	wire [3:0]  sum;
	wire [4:0] sum5bit;
	wire  	    cout;
	assign A_LED = A;
	assign B_LED = B;
	supply1 [7:0] vcc;
    wire DONT_USE, clk_5KHz;
    wire [7:0] seg7sum1s;
    wire [7:0] seg7sum10s;
    wire [7:0] seg7carry;
    
    wire [3:0] sum1s;
    wire [3:0] sum10s;
    
    cla_adder TOP(A, B, carry, sum, cout);
    
    assign sum1s = {cout , sum} % 10;
    assign sum10s = {cout,sum} / 10;
	clk_gen CLK (clk100MHz, rst, DONT_USE, clk_5KHz);
	bcd_to_7seg BCDSUM1S (sum1s, seg7sum1s);
	bcd_to_7seg BCDSUM10S (sum10s, seg7sum10s);
	bcd_to_7seg BCDCARRY({3'b0,carry}, seg7carry);
	led_mux LED (clk_5KHz, rst, seg7carry, vcc, vcc, vcc, vcc, vcc, seg7sum10s, seg7sum1s,
        LEDSEL, LEDOUT);
	
endmodule
