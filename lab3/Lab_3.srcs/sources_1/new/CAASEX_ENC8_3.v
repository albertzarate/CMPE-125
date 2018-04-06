`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2018 03:06:29 PM
// Design Name: 
// Module Name: CAASEX_ENC8_3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CAASEX_ENC8_3(output reg [2:0] Y,
                     output reg Valid,
                     input wire [7:0] A

    );
always@(A)
begin
    Valid = 1;
    casex(A)
        8'b 1xxxxxxx: Y = 7;
        8'b 01xxxxxx: Y = 6;
        8'b 001xxxxx: Y = 5;
        8'b 0001xxxx: Y = 4;
        8'b 00001xxx: Y = 3;            
        8'b 000001xx: Y = 2;
        8'b 0000001x: Y = 1;
        8'b 00000001: Y = 0;
        default:
                begin
                        Valid = 0;
                        Y = 3'bX;
                end
     endcase
end
endmodule
