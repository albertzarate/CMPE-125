`timescale 1ns / 1ps

module fifoQ(input clk, rst,
             input wnr, en,
             input [3:0] D_in,
             output reg [3:0] D_out,
             output reg full, empty
             );

parameter bus_width = 4; 
parameter addr_width = 3;
parameter fifo_depth = 8;

reg [addr_width:0] r_ptr, w_ptr; // read and write pointers
// Pay attention on their size!!!
reg [bus_width-1:0] mem [fifo_depth-1:0]; // memory used by the FIFO


always @(posedge clk, posedge rst) begin
    if (rst) begin // if reset
        r_ptr = 1'b0; 
        w_ptr = 1'b0;
        D_out = 1'b0;
    end
    else if (!en) begin // if not enabled
        D_out = 'bz;
    end
    else if (wnr == 1 && !full) begin   //Write
        mem[w_ptr[addr_width-1:0]] = D_in; 
        w_ptr = w_ptr + 1;
    end
    else if (wnr == 0 && !empty) begin    //Read
        D_out = mem[r_ptr[addr_width-1:0]]; 
        r_ptr = r_ptr + 1;
    end
    else begin //idk what this is
        D_out = 'bz;
    end
end

always @(r_ptr, w_ptr)begin
    if (r_ptr == w_ptr)begin 
        empty = 1; 
        full = 0; 
    end
    else if (r_ptr[addr_width-1:0] == w_ptr[addr_width-1:0])begin 
        empty = 0; 
        full = 1; 
    end
    else begin 
        empty = 0; 
        full = 0; 
    end
end
endmodule
