`timescale 1ns / 1ps

module ALU (
    input wire [2:0] ctrl,
    input wire [3:0] A, 
    input wire [3:0] B, 
    output reg [3:0] out,
    output reg [0:0] zero, 
    output reg [0:0] overflow
    );
    
    always @ (ctrl, A, B)
    begin
                if (ctrl[2]) begin //logic operation
                    case (ctrl[1:0])
                        2'b00: {overflow, out} = A - 1; // decrement
                        2'b01: {overflow, out} = A + B; //addition
                        2'b10: {overflow, out} = A - B; //subtraction
                        default: {overflow, out} = A + 1; // increment
                    endcase
                end
                else begin//arithmetic operation        
                    case (ctrl[1:0])
                        2'b00: out = ~A; //bitwise negation
                        2'b01: out = A & B; //bitwise AND
                        2'b10: out = A ^ B; //bitwise XOR
                        default: out = A | B; //bitwise OR
                    endcase
                    overflow = 1'b0;
                end
            zero = (out == 4'b0) ? 1'b1 : 1'b0;
            //add overflow case   
    end
endmodule