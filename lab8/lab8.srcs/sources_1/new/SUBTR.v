`timescale 1ns / 1ps

module subtr(
            input [3:0] in_a, in_b,
            output [3:0] c
            );

assign c = in_a - in_b;

endmodule
