`timescale 1ns / 1ps

module tb_ALU;
    reg [2:0] ctrl;
    reg [3:0] A;
    reg [3:0] B;
    wire [3:0] out;
    wire [0:0] zero;
    wire [0:0] overflow;

    reg [3:0] tb_out;
    reg [0:0] tb_zero;
    reg [0:0] tb_overflow;

    integer i_ctrl;
    integer i_A;
    integer i_B;

    ALU U0(
        .ctrl (ctrl),
        .A (A),
        .B (B),
        .out (out),
        .zero (zero),
        .overflow (overflow)
        );
        
    initial begin
        for (i_ctrl = 0; i_ctrl < 8; i_ctrl = i_ctrl + 1) begin
            for (i_A = 0; i_A < 16; i_A = i_A + 1) begin
                for (i_B = 0; i_B < 16; i_B = i_B + 1) begin
                    ctrl = i_ctrl;
                    A = i_A;
                    B = i_B;
                    
                    if (ctrl[2]) begin //logic operation
                        case (ctrl[1:0])
                            2'b00: {tb_overflow, tb_out} = A - 1; // decrement
                            2'b01: {tb_overflow, tb_out} = A + B; //addition
                            2'b10: {tb_overflow, tb_out} = A - B; //subtraction
                            default: {tb_overflow, tb_out} = A + 1; // increment
                        endcase
                    end
                    else begin//arithmetic operation        
                        case (ctrl[1:0])
                            2'b00: tb_out = ~A; //bitwise negation
                            2'b01: tb_out = A & B; //bitwise AND
                            2'b10: tb_out = A ^ B; //bitwise XOR
                            default: tb_out = A | B; //bitwise OR
                        endcase
                        tb_overflow = 1'b0;
                    end
                    tb_zero = (tb_out == 4'b0) ? 1'b1 : 1'b0;
                    #5;
                    
                    if (tb_out != out) begin
                        $display("Error! tb output did not match output");
                    end
                    if (tb_zero != zero) begin
                        $display("Error! tb zero did not match zero");
                    end
                    if (tb_overflow != overflow) begin
                        $display("Error! tb overflow did not match overflow");
                    end
    
                end
            end
        end
    end
endmodule