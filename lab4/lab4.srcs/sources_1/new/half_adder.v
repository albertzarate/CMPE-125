`timescale 1ns / 1ps

module half_adder(
    input wire  a, 
    input wire  b,
    output wire p,
    output wire g
    );

    xor_gate SUP(
    	.in1       (a),
    	.in2       (b),
    	.out       (p)
    	);

    assign g = a & b;

endmodule
