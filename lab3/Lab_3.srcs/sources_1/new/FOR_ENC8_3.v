`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2018 03:15:48 PM
// Design Name: 
// Module Name: FOR_ENC8_3
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


module FOR_ENC8_3(output reg [2:0] Y,
                  output reg Valid,
                  input wire [7:0] A
    );
integer N;

always@(A)
begin
    Valid = 0;
    Y = 3'bX;
    for (N = 0; N < 8; N = N + 1)
    if (A[N])
            begin
                Valid = 1;
                Y = N;
            end
end 
endmodule
