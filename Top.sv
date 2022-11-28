`timescale 1ns / 1ps


module Top(
    input CLK100MHZ, reset,
    input [7:0] A, B,
    input pb_entrada,
    output [15:0] LED,
    output [3:0] anodo,
    output [6:0] catodo
    );
    
    logic [7:0] multiplicador, multiplicando;
    logic pb_salida;
    logic [7:0] A_sinrebote, B_sinrebote;
    reg valid, done1;
    logic [15:0] Mult;
    logic signo;
    logic [14:0] bin;
    logic [19:0] codigo_BCD_sin_signo;
    logic [20:0] codigo_BCD;
    reg done2;
    
    Reading Lectura (CLK100MHZ, reset, A, B, pb_entrada, LED, multiplicador, multiplicando, pb_salida);
    
    always @(posedge CLK100MHZ)
    begin
        if (pb_salida)
        begin
            valid <= pb_salida;
            A_sinrebote <= multiplicador;
            B_sinrebote <= multiplicando;
        end
        else if (reset)
        begin
            valid <= 0;
            A_sinrebote <= 0;
            B_sinrebote <= 0;
        end
        else
        begin
            A_sinrebote <= A_sinrebote;
            B_sinrebote <= B_sinrebote;
        end
    end
    
    Multiplier Multiplicacion (CLK100MHZ, reset, valid, A_sinrebote, B_sinrebote, Mult, done1);
    
    always @(posedge CLK100MHZ)
    begin
        if (done1)
        begin
            signo <= Mult[15];
            if (signo)
                bin <= -Mult[14:0]+1;
            else
                bin <= Mult[14:0];
        end
        else if (reset)
        begin
            signo <= 0;
            bin <= 0;
        end
        else
        begin
            signo <= signo;
            bin <= bin;
        end
    end
    
    binaryToBCD BCD (CLK100MHZ, reset, done1, bin, codigo_BCD_sin_signo, done2);
    
    always @(posedge CLK100MHZ)
    begin
        if (done2)
            codigo_BCD <= {signo, codigo_BCD_sin_signo};
        else if (reset)
            codigo_BCD <= 0;
        else
            codigo_BCD <= codigo_BCD;
    end

    sevenSegmentDisplay Display (CLK100MHZ, reset, codigo_BCD, anodo, catodo);
    
endmodule
