`timescale 1ns / 1ps

module tb_divider_DP();

reg [3:0] x, y;                            
reg R_mux_ctrl;
reg Rem_mux_ctrl;                           
reg X_mux_ctrl;                             
reg Q_mux_ctrl;                             
reg R_shift_left;
reg R_shift_right; 
reg R_load;                       
reg X_shift_left; 
reg X_load;                            
reg Y_load;                                                             
reg count_load; 
reg count_CE;                        
reg clk;
reg rst;                               
wire lt_flag;
wire divide_by_zero;                    
wire [3:0] R, Q, count_out;

reg [3:0] tb_quotient, tb_remainder;
reg tb_divide_by_zero;
integer x_in, y_in, error;

DP DUT(
    .x(x),
    .y(y),
    .R_mux_ctrl(R_mux_ctrl),
    .X_mux_ctrl(X_mux_ctrl),
    .Rem_mux_ctrl(Rem_mux_ctrl),
    .Q_mux_ctrl(Q_mux_ctrl),
    .R_shift_left(R_shift_left),
    .R_load(R_load),
    .R_shift_right(R_shift_right),
    .X_shift_left(X_shift_left),
    .X_load(X_load),
    .Y_load(Y_load),
    .count_load(count_load),
    .count_CE(count_CE),
    .clk(clk),
    .rst(rst),
    .lt_flag(lt_flag),
    .divide_by_zero(divide_by_zero),
    .count_out(count_out),
    .R(R),
    .Q(Q)
    );

task tick;
    begin
        clk=1'b0; #10;
        clk=1'b1; #10;
    end
endtask

initial begin
    error = 0;
    rst=1'b1;
    tick;
    rst=1'b0;
    
    for(x_in=0; x_in<16; x_in=x_in+1) begin
        x=x_in;
        for(y_in=0; y_in<16; y_in=y_in+1) begin
            tb_divide_by_zero=1'b0;
            y=y_in; #5;
            if(y==0) begin
                tb_divide_by_zero=1'b1;
            end
            if(tb_divide_by_zero!=divide_by_zero) begin
                $display("Divide by zero error!!!! what u spposed to get %d, actual %d", tb_divide_by_zero, divide_by_zero);
                error = error + 1;
            end
            Rem_mux_ctrl=1'b0; //s0
            Q_mux_ctrl=1'b0;

            R_mux_ctrl=1'b0; //s1   R[4:0] <--0
            R_load=1'b1;
            X_load=1'b1;//X<-dividend
            Y_load=1'b1;//Y<-dividend
            //count<-4
           // count_n=4'b0100;
            count_load=1'b1;
            count_CE=1'b1;
            
            tick;
            
            R_load=1'b0; //s2
            X_load=1'b0;
            Y_load=1'b0;
            count_load=1'b0;
            count_CE=1'b0;
            R_shift_left=1'b1;//R[4:0]<-{R[3:0],X[3]
            X_mux_ctrl=1'b0;//X[3:0]<-{X[2:0],0}
            X_shift_left=1'b1;
            
            tick;
            
            while(count_out!=4'b0000) begin //s3
                R_shift_left=1'b0;
                X_shift_left=1'b0;
                count_CE=1'b1;
                
                tick;
                
                if(lt_flag) begin//s5
                    count_CE=1'b0;
                    R_shift_left=1'b1;
                    X_mux_ctrl=1'b0;
                    X_shift_left=1'b1;
                end else begin //s4
                    count_CE=1'b0;
                    R_mux_ctrl=1'b1;
                    R_load=1'b1; 

                    tick;
                    
                    R_load=1'b0;
                    R_mux_ctrl=1'b0;
                    R_shift_left=1'b1;
                    X_mux_ctrl=1'b1;
                    X_shift_left=1'b1;
                end
                
                tick;
                X_mux_ctrl=1'b0;
                R_shift_left=1'b0;
                X_shift_left=1'b0;
            end
            R_shift_right=1'b1; //s6
            tick;
            R_shift_right=1'b0;
            Rem_mux_ctrl=1'b1;//s7
            Q_mux_ctrl=1'b1;
            
            tick;
            
            tb_quotient=x/y;
            tb_remainder=x%y;
            
            if(tb_quotient!=Q) begin
                $display("thought %d, actual %d", tb_quotient, Q);
                error = error + 1;
            end
            if(tb_remainder!=R) begin
                $display("x: %d, y: %d", x, y);
                $display("thought %d, actual %d", tb_remainder, R);
                error = error + 1;
            end
        end
    end
    $display("u dun. errors %d", error);
end

endmodule
