`timescale 1ns / 1ps

module tb_two_stage_mult();
reg [3:0] 	A;
reg [3:0] 	B;
reg 	  	clk100MHz;
wire [7:0] 	preg;
reg [7:0] tb_preg;


integer A_in;
integer B_in;
integer error;

reg [7:0] queue[2:0];
integer i = 0;

task tick; 
begin
	clk100MHz = 1'b0;
	#5;
	clk100MHz = 1'b1;
	#5;
end
endtask

two_stage_multiplier TSM (
    .A        (A),
    .B        (B),
    .clk100MHz(clk100MHz),
    .rst      (1'b0),
    .preg     (preg)
);

initial begin
    error = 0;
    for (A_in = 0; A_in < 16; A_in = A_in + 1) begin
    	for (B_in = 0; B_in < 16; B_in = B_in + 1) begin
    		A = A_in;
    		B = B_in;   		
    		tb_preg = A * B;
    		queue[i % 3] = tb_preg; 
            i = i + 1; 
    		tick;
    		if (i >= 3 && preg != (queue[i % 3]))
    		begin
    		    $display("Error! preg: %d, tb_preg: %d", preg, tb_preg);
    		end 
		end
	end
	i = i + 1;
	tick;
	if (i >= 3 && preg != (queue[i % 3]))
        begin
            $display("Error! preg: %d, tb_preg: %d", preg, tb_preg);
        end
    i = i + 1;
	tick;
	if (i >= 3 && preg != (queue[i % 3]))
        begin
            $display("Error! preg: %d, tb_preg: %d", preg, tb_preg);
        end
end
endmodule
