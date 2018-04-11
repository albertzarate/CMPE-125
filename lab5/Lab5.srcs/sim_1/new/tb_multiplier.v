`timescale 1ns / 1ps

module tb_multiplier();
reg [3:0] A;
reg [3:0] B;
wire [7:0] out_inferred;
wire [7:0] out_4bm;

integer A_in;
integer B_in;
integer error;

multiplier_4bit SUP (
    .A(A),
    .B(B),
    .P(out_inferred)
);

top_level_multiplier WASSUP (
    .A(A),
    .B(B),
    .P(out_4bm)
);

initial begin
    error = 0;
    for (A_in = 0; A_in < 16; A_in = A_in + 1) begin
    	for (B_in = 0; B_in < 16; B_in = B_in + 1) begin
    		A = A_in;
    		B = B_in;

    		#5;

    		if (out_inferred != out_4bm) begin
    			$display("Error! Out_4bm: %d, Out_inferred: %d", out_4bm, out_inferred);
    			error = error + 1;
    		      end
    		end
    	end
    end
endmodule
