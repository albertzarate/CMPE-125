`timescale 1ns / 1ps

module tb_reg_file();

reg clk; // Synchronous Clock
reg [31:0] wd1; // Data Input to the RF
reg [31:0] wd2;
reg [4:0] wa1; // Write Address of the RF
reg [4:0] wa2; // Write Address of the RF
reg we1; // Write Enable of the RF
reg we2;
reg [4:0] ra1; // Read Address of the RF's Port A
reg [4:0] ra2; // Read Address of the RF's Port B
wire [31:0] rd1; // Read Enable of the RF's Port A
wire [31:0] rd2; // Read Enable of the RF's Port B



reg[31:0] tb_rf[31:0];

reg_file DUT (
                .clk(clk),
                .we1(we1), .we2(we2),
                .ra1(ra1), .ra2(ra2), 
                .wa1(wa1), .wa2(wa2),
                .wd1(wd1), .wd2(wd2),
                .rd1(rd1), .rd2(rd2)
                );


task tick; 
begin
	clk = 1'b0;
	#5;
	clk = 1'b1;
	#5;
end
endtask

task reset; 
begin
	we1 = 1'b0;
	we2 = 1'b0;
end
endtask

integer error;
integer i;
integer j;
initial begin
	error = 0;
////////////////////////////////////////////////////////////////////////////////////////////////////////write	
	reset;
    
	we1 = 1'b1;
	for (i = 0; i < 32; i = i + 1) begin	//Single Write Wd1
		wa1 = i;
		ra1 = i;
		wd1 = wa1 + 3;
		tick;
		tb_rf[wa1] = wd1;

		if (rd1 != tb_rf[wa1]) begin
			$display("Single Write Wd1. Rd1: %d tb_rf[wa1]: %d", rd1, tb_rf[wa1]);
			error = error + 1;
		end
	end

	reset;

	we2 = 1'b1;
	for (i = 0; i < 32; i = i + 1) begin	//Single Write Wd2
		wa2 = i;
		ra2 = i;
		wd2 = wa2 + 5;
		tick;
		tb_rf[wa2] = wd2;

		if (rd2 != tb_rf[wa2]) begin
			$display("Single Write Wd2. Rd2: %d tb_rf[wa2]: %d", rd2, tb_rf[wa2]);
			error = error + 1;
		end
	end

	reset;

	we1 = 1'b1;
	we2 = 1'b1;
	for (i = 0; i < 32; i = i + 1) begin	//sim write diff address
		for (j = 31; j >= 0; j = j - 1) begin
			wa1 = i;
			wa2 = j;
			ra1 = i;
			ra2 = j;
			wd1 = wa1 + 3;
			wd2 = wa2 + 5;
			tick;
			tb_rf[wa1] = wd1;
			tb_rf[wa2] = wd2;

			if (rd1 != tb_rf[wa1]) begin
				$display("sim write diff address part 1. Rd1: %d tb_rf[wa1]: %d", rd1, tb_rf[wa1]);
				error = error + 1;
			end

			if (rd2 != tb_rf[wa2]) begin
				$display("sim write diff address part 2. Rd2: %d tb_rf[wa2]: %d", rd2, tb_rf[wa2]);
				error = error + 1;
			end
		end
	end
//////////////////////////////////////////////////////////////////////////////////////////////////////////read
    reset;
	for (i = 0; i < 32; i = i + 1) begin	//Single Read Ra1
		ra1 = i;
		tick;
		if (rd1 != tb_rf[ra1]) begin
			$display("Single Read Ra1. Rd1: %d Ra1: %d", rd1, ra1);
			error = error + 1;
		end
	end

	for (i = 0; i < 32; i = i + 1) begin	//Single Read Ra2
		ra2 = i;
		tick;
		if (rd2 != tb_rf[ra2]) begin
			$display("Single Read Ra2. Rd2: %d Ra2: %d", rd2, ra2);
			error = error + 1;
		end
	end

	for (i = 0; i < 32; i = i + 1) begin	// Simultaneous Read Same Address
		ra1 = i;
		ra2 = i;
		tick;
		if (rd1 != tb_rf[ra1]) begin
			$display("Simultaneous Read Same Address part 1. Rd1: %d Ra1: %d", rd1, ra1);
			error = error + 1;
		end

		if (rd2 != tb_rf[ra2]) begin
			$display("Simultaneous Read Same Address part 2. Rd2: %d Ra2: %d", rd2, ra2);
			error = error + 1;
		end
	end

	for (i = 0; i < 32; i = i + 1) begin	//Simultaneous Read Different Addresses
		for (j = 31; j >= 0; j = j - 1) begin
			if (i != j) begin
				ra1 = i;
				ra2 = j;
				tick;
				if (rd1 != tb_rf[ra1]) begin
					$display("Simultaneous Read Different Addresses part 1. Rd1: %d Ra1: %d", rd1, ra1);
					error = error + 1;
				end

				if (rd2 != tb_rf[ra2]) begin
					$display("Simultaneous Read Different Addresses part . Rd2: %d Ra2: %d", rd2, ra2);
					error = error + 1;
				end
			end
		end
	end
	tick;
	tick;
	tick;
	i = 13; //d
	ra1 = i;
	ra2 = i;
	wa1 = i;
	wd1 = i;
	we1 = 1;
	tick;
	tick;
	
	$display("errors = %d", error);
	$finish;
end
endmodule // tb_reg_file
