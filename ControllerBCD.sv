`timescale 1ns / 1ps

module ControllerBCD(
    input [20:0] codigo_BCD, 
    input [2:0] contador_actualizar,
    output reg [3:0] digito = 0 
    );

    always @ (codigo_BCD, contador_actualizar)
        begin
            case (contador_actualizar)
            3'b000: 
                digito = codigo_BCD [3:0]; 
            3'b001: 
                digito = codigo_BCD [7:4]; 
            3'b010: 
                digito = codigo_BCD [11:8]; 
            3'b011: 
                digito = codigo_BCD [15:12]; 
            default:
                digito = codigo_BCD [3:0]; 
            endcase
        end
    
endmodule
