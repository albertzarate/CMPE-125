`timescale 1ns / 1ps

module DP(
        input [3:0] x, y,
        input R_mux_ctrl,
        input Rem_mux_ctrl,
        input X_mux_ctrl,
        input Q_mux_ctrl,
        input R_shift_left, 
        input R_shift_right, 
        input R_load,
        input X_shift_left, 
        input X_load,
        input Y_load,
        input count_CE, 
        input count_load,
        input clk, 
        input rst,
        output lt_flag, 
        output divide_by_zero,
        output [3:0] Q, R, count_out
        );

wire X_R_in;
wire [4:0] R_in, R_out;
wire [3:0] X_out, Y_out, subtr_out;

mux2 #(.data_width(5)) M0( //first mux
            .d0(5'b0),
            .d1({R_out[4], subtr_out}),
            .out(R_in),
            .sel(R_mux_ctrl)
            );
                        
shift_reg #(.data_width(5)) S0( //R reg
            .clk(clk),
            .rst(rst),
            .SR(R_shift_right),
            .SL(R_shift_left),
            .LD(R_load),
            .D(R_in),
            .Q(R_out),
            .R_in(X_out[3]),
            .L_in(1'b0)
            );
                            
mux2 #(.data_width(1)) M1( //mux for x
            .d0(1'b0),
            .d1(1'b1),
            .out(X_R_in),
            .sel(X_mux_ctrl)
            );

shift_reg #(.data_width(4)) S1( //x reg
            .clk(clk),
            .rst(rst),
            .SR(1'b0),  
            .SL(X_shift_left),
            .LD(X_load),
            .D(x),
            .Q(X_out),
            .R_in(X_R_in),
            .L_in(1'b0)
            );
                            
shift_reg #(.data_width(4)) S2( //Y reg
            .clk(clk),
            .rst(rst),
            .SR(1'b0),  
            .SL(1'b0),
            .LD(Y_load),
            .D(y),
            .Q(Y_out),
            .R_in(1'b0),
            .L_in(1'b0)
            );
                            
comparator C1( //check R < Y
            .in_a(R_out[3:0]),
            .in_b(Y_out),
            .lt(lt_flag)
            );
         
comparator_zero C2( // check div by zero
            .in_a(y),
            .in_b(5'b00001),
            .lt(divide_by_zero)
            );
        
subtr S3( // subtract
            .in_a(R_out[3:0]),
            .in_b(Y_out),
            .c(subtr_out)
            );
        
mux2 #(.data_width(4)) M2( //mux for remainder
            .d0(4'b0),
            .d1(R_out[3:0]),    
            .out(R),
            .sel(Rem_mux_ctrl)
            );
                        
mux2 #(.data_width(4)) M3( //mux for quotient
            .d0(4'b0),
            .d1(X_out),
            .out(Q),
            .sel(Q_mux_ctrl)
            );
                        
up_down_counter U1(
            .D(3'b100),
            .LD(count_load),
            .UD(1'b0),
            .CE(count_CE),
            .rst(~rst),
            .clk(clk),
            .Q(count_out)
            );
    
endmodule
