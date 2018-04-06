`timescale 1ns / 1ps

module tb_shifter;

reg  [2:0] ctrl;
reg  [3:0] in;
wire [3:0] out;

reg  [3:0] tb_out;

integer i_ctrl;
integer i_in;

integer error;

right_shifter_rotator DUT(
    .ctrl (ctrl),
    .D_in   (in),
    .D_out  (out)
    );

initial begin
    error = 0;
	for (i_ctrl = 0; i_ctrl < 8; i_ctrl = i_ctrl + 1) begin
        for (i_in = 0; i_in < 16; i_in = i_in + 1) begin
            ctrl = i_ctrl;
			in = i_in;
             
			case (ctrl)
				3'b000: tb_out = in;
				3'b001: tb_out = in >> 1;
				3'b010: tb_out = in >> 2;
				3'b011: tb_out = in >> 3;
				3'b100: tb_out = in >> 4;
				3'b101: tb_out = {in[0], in[3:1]}; 
				3'b110: tb_out = {in[1:0], in[3:2]};
				3'b111: tb_out = {in[2:0], in[3]};
			   default: tb_out = 4'bz;
			endcase // ctrl
            
            #5;

            if(out != tb_out) begin
                $display("Error! Wrong Result Ctrl: %d, In: %d", ctrl, in);
                error = error + 1;
            end
		end
    end
    $display("%d Error(s)", error);
end
endmodule
