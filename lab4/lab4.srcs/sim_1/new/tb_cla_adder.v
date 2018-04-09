`timescale 1ns / 1ps

module tb_cla_adder(); 
reg [3:0]  A;
reg [3:0]  B;
reg 	   carry;
wire [3:0] sum_cla;
wire [3:0] sum_adder;
wire 	   cout_cla;
wire 	   cout_adder;


//reg [3:0] tb_sum_cla;
//reg [3:0] tb_sum_adder;
//reg 	  tb_cout;

integer A_in;
integer B_in;
integer carry_in;
integer error;

cla_adder CLA_ADD (
    .A(A),
    .B(B),
    .carry(carry),
    .sum(sum_cla),
    .cout(cout_cla)
    );

adder INF_ADD (
    .carry(carry),
    .A(A),
    .B(B),
    .sum(sum_adder),
    .cout(cout_adder)
    );

initial begin
    error = 0;
    for(carry_in = 0; carry_in < 2; carry_in = carry_in + 1) begin
        for (A_in = 0; A_in < 16; A_in = A_in + 1) begin
            for (B_in = 0; B_in < 16; B_in = B_in + 1) begin
                A = A_in;
                B = B_in;
                carry = carry_in;
                #5;

                if (sum_cla != sum_adder) begin
                    $display("Error! Sums do not match!");
                    error = error + 1;
                end
            end
        end
    end
end

endmodule
