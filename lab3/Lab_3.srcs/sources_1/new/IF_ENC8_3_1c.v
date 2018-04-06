`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2018 04:21:01 PM
// Design Name: 
// Module Name: IF_ENC8_3_1c
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


module IF_ENC8_3_1c(
	output reg [2:0] Y,
    output reg Valid,
    input wire [7:0] A
    //output reg [7:0] lit
);
    
always@(A)
begin
    Valid = 1;
    if (A[7]) 
    begin
            Y = 7;
            //lit[7] = 0;
    end
    
    else if (A[6])
    begin
            Y = 6;
            //lit[6] = 0; 
    end
    
    else if (A[5]) 
    begin
            Y = 5;
           // lit[5] = 0;
    end
            
    else if (A[4]) 
    begin
            Y = 4;
          //  lit[4] = 0;
    end
    
    else if (A[3]) 
    begin
            Y = 3;
         //   lit[3] = 0;
    end
    
    else if (A[2]) 
    begin
            Y = 2;
          //  lit[2] = 0;
    end
   
    else if (A[1]) 
    begin
            Y = 1;
           // lit[1] = 0;
    end
    else if (A[0]) 
    begin
            Y = 0;
           // lit[0] = 0;
    end
    else
        begin
                Valid = 0;
                Y = 4'bx;     
        end
 end
 endmodule // IF_ENC8_3_1c    
