`timescale 1ns / 1ps

module reg_file(input clk,
                input we1, we2,
                input [4:0] ra1, ra2, wa1, wa2,
                input [31:0] wd1, wd2,
                output [31:0] rd1, rd2);

reg[31:0] rf[31:0];
always @(posedge clk) begin
    if (we1) rf[wa1] <= wd1; //write 1
    if (we2) rf[wa2] <= wd2; //write 2
    end
    
    //assign rd1 = (ra1 != 0) ? rf[ra1] : 0; //read 1
    //assign rd2 = (ra2 != 0) ? rf[ra2] : 0; //read 2                 
         
    assign rd1 = rf[ra1];
    assign rd2 = rf[ra2];
endmodule
