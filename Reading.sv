`timescale 1ns / 1ps

module Reading(
    input CLK100MHZ, reset,
    input [7:0] A, B,
    input pb_entrada,
    output [15:0] LED,

    output [7:0] multiplicador, multiplicando,
    output logic pb_salida
    );
    
    logic pb_sinrebote;

    antirrebote A0 (CLK100MHZ, reset, A[0], multiplicador[0]);
    antirrebote A1 (CLK100MHZ, reset, A[1], multiplicador[1]);
    antirrebote A2 (CLK100MHZ, reset, A[2], multiplicador[2]);
    antirrebote A3 (CLK100MHZ, reset, A[3], multiplicador[3]);
    antirrebote A4 (CLK100MHZ, reset, A[4], multiplicador[4]);
    antirrebote A5 (CLK100MHZ, reset, A[5], multiplicador[5]);
    antirrebote A6 (CLK100MHZ, reset, A[6], multiplicador[6]);
    antirrebote A7 (CLK100MHZ, reset, A[7], multiplicador[7]);

    antirrebote B0 (CLK100MHZ, reset, B[0], multiplicando[0]);
    antirrebote B1 (CLK100MHZ, reset, B[1], multiplicando[1]);
    antirrebote B2 (CLK100MHZ, reset, B[2], multiplicando[2]);
    antirrebote B3 (CLK100MHZ, reset, B[3], multiplicando[3]);
    antirrebote B4 (CLK100MHZ, reset, B[4], multiplicando[4]);
    antirrebote B5 (CLK100MHZ, reset, B[5], multiplicando[5]);
    antirrebote B6 (CLK100MHZ, reset, B[6], multiplicando[6]);
    antirrebote B7 (CLK100MHZ, reset, B[7], multiplicando[7]);
    
    antirrebote PB (CLK100MHZ, reset, pb_entrada, pb_sinrebote);
    

    inicio_multiplicacion Inicio (CLK100MHZ, reset, pb_sinrebote, pb_salida);
    
    encender_lucesLED LucesLED (reset, multiplicador, multiplicando, pb_salida, LED);
   
endmodule

module antirrebote(
    input clk, reset, entrada,
    output salida
    );
    
    wire slow_clk_en;
    wire Q0, Q1, Q2, Q3;
    
    clock_enable u1 (clk, reset, slow_clk_en);
    
    FF F0 (clk, slow_clk_en, entrada, Q0);
    FF F1 (clk, slow_clk_en, Q0, Q1);
    FF F2 (clk, slow_clk_en, Q1, Q2);
    FF F3 (clk, slow_clk_en, Q2, Q3);
    
    assign salida = Q0 && Q1 && Q2 && Q3;
    
endmodule

module clock_enable(
    input Clk_100M, reset,
    output slow_clk_en
    );
    
    reg [25:0]contador = 0;
    
    always @(posedge Clk_100M)
    begin
        if (reset)
            contador <= 0;
        else
            contador <= (contador>=249999)?0:contador+1;
    end
    assign slow_clk_en = (contador == 249999)?1'b1:1'b0;
    
endmodule

module FF(
    input DFF_CLOCK, clock_enable, D,
    output reg Q = 0
    );
    
    always @ (posedge DFF_CLOCK) begin
        if(clock_enable == 1) 
           Q <= D;
        end
        
endmodule

module inicio_multiplicacion (
    input clk, reset, pb_sinrebote,
    output logic pb_salida = 0
    );

    localparam limite = 249999*2; 

    reg activador = 0;
    reg [25:0] contador = 0;
    
    always @(pb_sinrebote)
    begin
        if (pb_sinrebote)
            activador = 1;
        else
            activador = 0;
    end
    
    always @(posedge clk)
    begin
        if(reset)
            contador <= 0;
        else
        begin
            if (contador == limite)
                contador <= 0;
            else
                contador <= contador +1;
        end
    end
    
    always @(posedge clk)
    begin
        if(reset)
            pb_salida <= 0;
        else
        begin
            if(contador == limite && activador)
                pb_salida <= pb_sinrebote;
            else if(!activador)
                pb_salida <= 0;
            else
                pb_salida <= pb_salida;
        end
    end
    
endmodule

module encender_lucesLED(
    input reset,
    input [7:0] A, B,
    input pb_salida,
    output [15:0] LED
    );
    
    assign LED = {A, B};

    
endmodule