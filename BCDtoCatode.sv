`timescale 1ns / 1ps

module BCDtoCatode(
    input [3:0] digito, 
    output reg [6:0] catodo = 0 
    );

    always @ (digito)
        begin
            case(digito)
                4'b0000:
                    catodo = 7'b0000001; 
                4'b0001:
                    catodo = 7'b1001111; 
                4'b0010:
                    catodo = 7'b0010010; 
                4'b0011:
                    catodo = 7'b0000110; 
                4'b0100:
                    catodo = 7'b1001100; 
                default:
                    catodo = 7'b0000001; 
            endcase
        end
    
endmodule
