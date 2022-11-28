`timescale 1ns / 1ps


module ControllerAnode(
    input [2:0] contador_actualizar,
    output reg [7:0] anodo = 0
    );

    always @ (contador_actualizar)
        begin
            case (contador_actualizar)
                3'b000:
                    anodo = 8'b11111110; 
                3'b001:
                    anodo = 8'b11111101; 
                3'b010:
                    anodo = 8'b11111011; 
                3'b011:
                    anodo = 8'b11110111; 
                default:
                    anodo = 8'b11111110; 
            endcase
        end
    
endmodule
