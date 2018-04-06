`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2018 04:27:35 PM
// Design Name: 
// Module Name: ENC8_3_top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ENC8_3_top_module(
	// input wire clk100MHz, 
	// input wire rst, 
	input wire [7:0] switches,
	// output wire [7:0] LEDSEL, 
	// output wire [7:0] LEDOUT,
	output wire [2:0] lit,
    output wire valid
);
    // supply1 [7:0] vcc;
    // wire DONT_USE, clk_5KHz;
    // wire [2:0] y;

    
    // assign lit = y;

    IF_ENC8_3_1c ENC (	
    	.A(switches),
        .Y(lit),
	    .Valid(valid)	     
    );
endmodule
