`timescale 1ns / 1ps

module right_shifter_rotator(
	input wire [2:0] ctrl,
	input wire [3:0] D_in,
	output reg [3:0] D_out
	);

reg I;
reg J;
always @ (ctrl, D_in)

begin
		case (ctrl)
			3'b000: D_out = D_in;
			3'b001: D_out = D_in >> 1;
			3'b010: D_out = D_in >> 2;
			3'b011: D_out = D_in >> 3;
			3'b100: D_out = 4'b0; 
			3'b101: begin // Rotate right 1 bit
						I = D_in [0]; // D_out = {D_in[0],
						D_out = (D_in >> 1) + {I, 3'b0}; // D_in[3:1]}
					end
			3'b110: begin // Rotate right 2 bits
						I = D_in [0]; // D_out = {D_in[0],
						J = D_in [1];
						D_out = (D_in >> 2) + {I, J, 2'b0}; // D_in[3:1]}
					end

			3'b111: begin // Rotate right 3 bits
						I = D_in [3]; 
						D_out = (D_in << 1) + I;
					end
		default: D_out = 4'bz;
	endcase
end
endmodule
