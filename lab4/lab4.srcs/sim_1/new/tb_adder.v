`timescale 1ns / 1ps


module tb_adder();
	reg  [3:0] A;
	reg  [3:0] B;
	wire [3:0] sum;
	wire       carry;

	reg [3:0] tb_sum;
	reg [0:0] tb_carry;

	integer A_in;
	integer B_in;
	integer error;

	adder DUT(
		.A(A),
		.B(B),
		.sum(sum),
		.carry(carry)
		);

	initial begin
	error = 0;
		for (A_in = 0; A_in < 16; A_in = A_in + 1) begin
			for (B_in = 0; B_in < 16; B_in = B_in + 1) begin
				A = A_in;
				B = B_in;

				{tb_carry, tb_sum} = A + B;

				#5;

				if (sum != tb_sum) begin
					$display("Error! Wrong Result! Sum: %d, A: %d, B: %d", sum, A, B); 
					error = error + 1;
				end
			end
		end
		$display("%d Error(s)", error);
	end
endmodule
