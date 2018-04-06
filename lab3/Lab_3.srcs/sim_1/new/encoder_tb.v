`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2018 03:29:05 PM
// Design Name: 
// Module Name: encoder_tb
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


module encoder_tb();
    reg [7:0] in;
    integer N;
    wire [2:0] out;
    wire valid;
    
    reg [7:0] in2;
    wire [2:0] out2;
    wire valid2;
    
    reg [7:0] in3;
    wire [2:0] out3;
    wire valid3;
    
    IF_ENC8_3 DUT(out, valid, in);
    CAASEX_ENC8_3 DUT2(out2, valid2, in2);
    FOR_ENC8_3 DUT3(out3, valid3, in3);
    initial begin
        for(N = 0; N < 256; N = N + 1)
        #1
        begin
            in = N;
            if (valid == 1)
                begin
                    $display("Valid is True");
                end
            if (valid == 0)
                begin
                    $display("Valid is False");
                end
            in2 = N;
                            if (valid2 == 1)
                                begin
                                    $display("Valid is True");
                                end
                            if (valid2 == 0)
                                begin
                                    $display("Valid is False");
                                end
                            in3 = N;
                                               if (valid3 == 1)
                                                   begin
                                                       $display("Valid is True");
                                                   end
                                               if (valid3 == 0)
                                                   begin
                                                       $display("Valid is False");
                                                   end
        end
        $finish;
    end 
endmodule
