`timescale 1ns / 1ps

module fpga_fifoQ(
    input clk100MHz,
    input debounce,
    input wire [3:0] D_in,
    input wnr, en, rst, 
    output wire [3:0] D_in_LED,
    output wire wnr_LED, 
    output wire en_LED,
    output wire [3:0] D_out,
    output wire empty, full
    );
    
    assign D_in_LED = D_in;
    assign wnr_LED = wnr;
    assign en_LED = en;
    wire DONT_USE, clk_5KHz, mclk;
    
    clk_gen CLK (clk100MHz, rst, DONT_USE, clk_5KHz);
    button_debouncer BD(clk_5KHz, debounce, mclk);
     
    fifoQ TOP(
        .clk(mclk), .rst(rst),
        .wnr(wnr), .en(en),
        .D_in(D_in),
        .D_out(D_out),
        .full(full), .empty(empty)
        );     
     
endmodule