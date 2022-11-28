`timescale 1ns / 1ps


module sevenSegmentDisplay(
    input clk,
    input reset,
    input [20:0] codigo_BCD,
    output [3:0] anodo,
    output [6:0] catodo
    );
    
    wire reloj_actualizacion;
    wire [2:0] contador_actualizar;
    wire [3:0] digito;
    
    ClockDivider Divisor_Reloj (clk, reset, reloj_actualizacion);
    updateCounter Contador (reloj_actualizacion, reset, contador_actualizar);
    
    ControllerAnode Anodo (contador_actualizar, anodo);
    ControllerBCD Control_BCD (codigo_BCD, contador_actualizar, digito);
    BCDtoCatode Catodos(digito, catodo);
    
endmodule
