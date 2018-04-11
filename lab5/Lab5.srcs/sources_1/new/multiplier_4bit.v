`timescale 1ns / 1ps

module multiplier_4bit(
    input wire [3:0] A,
	input wire [3:0] B,
	output wire [7:0] P
    );
    assign P = A * B; 
endmodule
