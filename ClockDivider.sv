`timescale 1ns / 1ps


module ClockDivider(
    input clk,
    input reset,
    output reg clk_dividido
    );

    localparam divisor = 4999; 

    reg [25:0] contador = 0;
    
    always @ (posedge clk)
        begin
            if (reset)
                contador <= 0;
            else
                if (contador == divisor)
                    contador <= 0;
                else
                    contador <= contador +1;
        end
    
    always @ (posedge clk)
        begin
            if (reset)
                clk_dividido <= ~clk_dividido;
            else
            begin
                if (contador == divisor)
                    clk_dividido <= ~clk_dividido;
                else
                    clk_dividido <= clk_dividido;
            end
        end
    
endmodule
