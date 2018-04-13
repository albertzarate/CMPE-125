`timescale 1ns / 1ps

module tb_fifoQ();

reg clk; // Synchronous Clock
reg rst;
reg wnr;
reg en;
reg [3:0] D_in;
wire [3:0] D_out;
wire full;
wire empty;

reg [3:0] tb_fifoQ;
reg tb_full, tb_empty;


fifoQ #(.bus_width(4), .addr_width(3), .fifo_depth(8))DUT (
            .clk(clk), .rst(rst),
            .wnr(wnr), .en(en),
            .D_in(D_in), .D_out(D_out), 
            .full(full), .empty(empty)
            );


task tick; 
begin
	clk = 1'b0;
	#5;
	clk = 1'b1;
	#5;
end
endtask


integer error;
integer i;
initial begin
    error = 0;
    rst = 1'b0;
    en = 1'b0;
    $display("Started TB");
    tick;
    rst = 1'b1;
    en = 1'b1;
    if(D_out == 0 || !empty || full) begin
        $display("reset error");
        error = error + 1;
    end
    tick;
	rst = 1'b0;
	en = 1'b1;
	wnr = 1'b1;
	for(i=0; i<8; i=i+1)begin //writes until Q is full
	   D_in = i;
	   tb_fifoQ = D_in;
	   tick;
	   if(i == 7 && (!full || empty))begin //full and empty flag error
	       $display("Error!!!!!!!!");
	       error = error + 1;
	   end
	   else if (i != 7 && (full || empty))begin //full and empty flag error
	       $display("Error!!!!!!!!");
           error = error + 1;
	   end
	   if(i == 7)begin //check full flag
	       tb_full = 1;
	   end
	   if(tb_full != full)begin
	       $display("full error");
	       error = error + 1;
	   end
	end
	
	wnr = 1'b0;
	for(i=0; i<8; i=i+1)begin //reads everything
       tb_fifoQ = i;
       tick;
       if(D_out != tb_fifoQ)begin
           $display("your q aint workin BOI..... D_out: %d     tb_fifoQ: %d", D_out, tb_fifoQ);
           error = error + 1;
       end
       if(i == 7 && (full || !empty))begin //full and empty flag errors
          $display("Error!!!!!!!!");
          error = error + 1;
      end
      else if (i != 7 && (full || empty))begin  //full and empty flag errors
          $display("Error!!!!!!!!");
          error = error + 1;
      end
      if(i == 7)begin
          tb_empty = 1;
      end
      if(tb_empty != empty)begin
          $display("empty error");
          error = error + 1;
      end
    end
    
    $finish;
end
endmodule