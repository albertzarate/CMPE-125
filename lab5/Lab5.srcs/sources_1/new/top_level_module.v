`timescale 1ns / 1ps


module fpga_two_stage_mult(
    input clk100MHz, 
	input rst,
	input debounce,
	input wire [3:0]  A,
	input wire [3:0]  B,
	output wire [3:0] A_LED,
    output wire [3:0] B_LED,
	output [7:0] LEDSEL, 
    output [7:0] LEDOUT
    );
    
    assign A_LED = A;
    assign B_LED = B;
    
    wire [7:0] P; 
    
    supply1 [7:0] vcc;
    wire DONT_USE, clk_5KHz, mclk;
    
    wire [7:0] seg7prod1s;
    wire [7:0] seg7prod10s;
    wire [7:0] seg7prod100s;
    
    wire [3:0] prod1s;
    wire [3:0] prod10s;
    wire [3:0] prod100s;
    
    assign prod1s = P % 10;
    assign prod10s = (P / 10) % 10;
    assign prod100s = P / 100;
    
    clk_gen CLK (clk100MHz, rst, DONT_USE, clk_5KHz);
    button_debouncer BD(clk_5KHz, debounce, mclk);
    
    two_stage_multiplier TOP (A, B, mclk, rst, P);
    
    bcd_to_7seg BCDPROD1S (prod1s, seg7prod1s);
    bcd_to_7seg BCDPROD10S (prod10s, seg7prod10s);
    bcd_to_7seg BCDPROD100s(prod100s, seg7prod100s);
    led_mux LED (clk_5KHz, rst, vcc, vcc, vcc, vcc, vcc, seg7prod100s, seg7prod10s, seg7prod1s,
        LEDSEL, LEDOUT);
    
endmodule
