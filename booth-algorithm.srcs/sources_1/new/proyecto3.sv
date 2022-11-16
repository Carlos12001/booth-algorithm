`timescale 1ns / 1ps



typedef struct packed {
    logic load_A;
    logic load_B;
    logic load_add;
    logic shift_HQ_LQ_Q_1;
    logic add_sub;
}ControlSignals;

module Init(input pushButton,reset ,logic[7:0]a,logic[7:0]b,logic[3:0]button,output logic[7:0]out, logic [3:0]anode, logic [7:0]cathode );
    ControlSignals controlsigns;
    logic enable;
    logic clk ;
    logic refreshclock;
    logic [2:0] Q_LSB;
    logic [7:0] Y;
    logic [13:0] leds;
    logic [1:0] refresh_counter;
    logic [3:0] ONE_DIGIT;
    logic [7:0] oa;
    logic [7:0] ob;

    Lectura L0(.pushButton(pushButton),.a(a),.b(b),.enable(enable),.oa(oa),.ob(ob));
    
    Leds U2(.a(a),.b(b),.leds(leds),.clk(clk));
    
    Multiplicador Multiplicador(.clk(clk),.rst(reset),.A(oa),.B(ob),.mult_control(controlsigns),.Q_LSB(Q_LSB),.Y(Y));
    
    Control Controlador(.valid(enable),.reset(reset),.clk(clk),.Q(Q_LSB),.load_A(controlsigns.load_A),.load_B(controlsigns.load_B),.load_add(controlsigns.load_add),.shift_HQ_LQ_Q_1(controlsigns.shift_HQ_LQ_Q_1),.add_sub(controlsigns.add_sub));
    
    ClockDivider Refreshclock_generator(.clk(clk),.divided_clk(refreshclock));

    RefreshCounter Refreshcounter_wrapper(.refresh_clock(refreshclock),.refresh_counter(refresh_counter));

    AnodoControl Anode_Control_wrapper(.refresh_counter(refresh_counter),.anode(anode));

    BCDControl BCD_Control_wrapper(.digit1(out[3:0]),.digit2(out[7:4]),.digit3(button[3:0]),.digit4(button[3:0]),.refresh_counter(refresh_counter),.ONE_DIGIT(ONE_DIGIT));

    BCDCathode BCD_to_Cathodes_Wrapper(.digit(ONE_DIGIT),.cathode(cathode));
    
endmodule



module BCDCathode(
input [3:0] digit,
output logic [7:0] cathode
);

always@(digit)
begin
    case(digit)
    4'd0:
        cathode = 8'b11000000;
    4'd1:
        cathode = 8'b11111001;
    4'd2:
        cathode = 8'b10100100;
    4'd3:
        cathode = 8'b10110000;
    4'd4:
        cathode = 8'b10011001;    
    4'd5:
        cathode = 8'b10010010;   
    4'd6:
        cathode = 8'b10000010;    
    4'd7:
        cathode = 8'b11111000;   
    4'd8:
        cathode = 8'b10000000;
    4'd9:
        cathode = 8'b10010000;
    default:
        cathode = 8'b11000000;
    endcase    
end

endmodule



module BCDControl(
input [3:0] digit1, //mas peque?o
input [3:0] digit2,
input [3:0] digit3,
input [3:0] digit4, //mas significativo
input [1:0] refresh_counter,
output logic[3:0] ONE_DIGIT
    );
always@(refresh_counter)
begin
    case (refresh_counter)
        2'd0:
            ONE_DIGIT = digit1;
        2'd1:
            ONE_DIGIT = digit2;
        2'd2:
            ONE_DIGIT = digit3;
        2'd3:
            ONE_DIGIT = digit4;
     endcase
end    
    
endmodule


module AnodoControl(
input [1:0] refresh_counter,
output logic [3:0] anode
);
always@(refresh_counter)
    begin
        case (refresh_counter)
            2'b00:
                anode = 4'b1110;
            2'b01:
                anode = 4'b1101;
            2'b10:
                anode = 4'b1011;
            2'b11:
                anode = 4'b0111;
           //default: anode = 3'b0;
         endcase
    end
endmodule


module RefreshCounter(
    input refresh_clock,
    output logic [1:0] refresh_counter);
    
    always@(posedge refresh_clock) refresh_counter <= refresh_counter +1;

endmodule


module Leds(input logic [7:0] a, input logic [7:0] b, output logic[13:0] leds, input logic clk);
    logic [25:0] counter = 26'd0;
    logic valid = 1;
    always @(posedge clk)
    begin
        if(valid)
        begin
             leds[13:8] = a;
             leds[7:0] = b;
        end
    end
    always @*
    begin
        if(counter == 26'd50000000)
            begin
                counter = 26'd0;
            end
        else
            begin
                counter = counter + 26'd1;
            end
         valid = (counter == 26'd50000000)? 1'b1:1'b0;
    end
endmodule



module Lectura(input pushButton ,a,b,output logic enable,oa,ob);
    logic clk;
    logic [7:0] a,b;
    logic [7:0]oa,ob;
    logic [3:0][7:0] FFA,FFB;
    
    logic [25:0]counter = 0;
    // Contador verifica 500ms
    always@(*)
    begin
        if(pushButton == 1'b1)
        begin
            if(counter == 26'd50000000)
                begin
                    counter <= 26'd0;
                end
            else
                begin
                    counter <= counter + 26'd1;
                end
            enable <= (counter == 26'd50000000)?1'b1:1'b0;
        end
    end

    //Antirebote
    always @(posedge clk)
    begin
        FFA <= {a,FFA[3],FFA[2],FFA[1]};
        FFB <= {b,FFB[3],FFB[2],FFB[1]};
    end
    
    always_comb
    begin
        oa <= FFA[3] & (~FFA[2]) & (~FFA[1]) & (~FFA[0]);
        ob <= FFB[3] & (~FFB[2]) & (~FFB[1]) & (~FFB[0]);
    end
endmodule


module ClockDivider(input logic clk,
    output logic divided_clk  
        );
        
    localparam div_value = 4999; // 10KHz
        
    integer counter_value =0;
    
    always@ (posedge clk)
    begin
        if (counter_value == div_value)
            counter_value <=0;
        else
            counter_value <= counter_value+1;  
    end
    // divide clock
    always@ (posedge clk)
    begin
        if (counter_value == div_value)
            divided_clk <= ~divided_clk;
        else
            divided_clk <= divided_clk;
    end

endmodule

module Control(input logic valid,reset,clk,[2:0]Q, output logic load_A,load_B,load_add,shift_HQ_LQ_Q_1,add_sub);
    typedef enum logic [1:0] {S0,S1,S2,S3} statetype;
    statetype [1:0] state,nextState;
    
    always_ff @(posedge clk,posedge reset)
        if(reset) state<= S0;
        else state <= nextState;
        
    always_comb 
    case(state)
    S0: nextState = S1;
    S1: nextState = S2;
    S2: nextState = S3;
    S3: nextState = S0;
    default: nextState = S0;
    endcase
    
    always @(posedge clk)
    begin
        case(state)
            S0: begin load_A=1;load_B=1;load_add=1;shift_HQ_LQ_Q_1=0;add_sub=0; end
            S1: if(Q[0] && Q[1]) begin load_A=0;load_B=0;load_add=0;shift_HQ_LQ_Q_1=1;add_sub=0; end
            S2: if((Q[0] ||  Q[1]) & Q == 2'b010) begin load_A=0;load_B=0;load_add=0;shift_HQ_LQ_Q_1=0;add_sub=0; end
            S3: if((Q[0] ||  Q[1]) & Q == 2'b001) begin load_A=0;load_B=0;load_add=0;shift_HQ_LQ_Q_1=0;add_sub=1; end
            default: begin load_A=0;load_B=0;load_add=0;shift_HQ_LQ_Q_1=0;add_sub=0; end
        endcase
    end
    
endmodule




///////
typedef struct packed{
    logic load_A;
    logic load_B;
    logic load_add;
    logic shift_HQ_LQ_Q_1;
    logic add_sub;
} multi_control_t;

module Multiplicador#(
    parameter N = 8
)(
    input logic clk,
    input logic rst,
    input logic [N-1:0]A,
    input logic [N-1:0]B,
    input multi_control_t mult_control,
    output logic [2:0] Q_LSB,
    output logic [2*N-1:0] Y);
    
    logic [N-1:0] M;
    logic [N-1:0] adder_sub_out;
    logic [2*N:0] shift;
    logic [N-1:0] HQ;
    logic [N-1:0] LQ;
    logic Q_1;
    //reg_m
    always_ff@(posedge clk or posedge rst) begin
        if(rst)
            M<='b0;
        else
            M<=(mult_control.load_A)? A:M;
    end
    //adder/sub
    always_comb begin
        if(mult_control.add_sub)
            adder_sub_out = M+HQ;
        else
            adder_sub_out = M-HQ;
    end
    //shiftRegister
    always_comb begin
        Y = {HQ,LQ};
        HQ = shift[2*N:N+1];
        LQ = shift[N:1];
        Q_1 = shift[0];
        Q_LSB = {LQ[0],Q_1};
    end

    always_ff@(posedge clk or posedge rst) begin
        if(rst)
            shift <='b0;
        else if( mult_control.shift_HQ_LQ_Q_1)
            //arithmetic shift
            shift <= $signed(shift)>>>1;
        else begin
            if(mult_control.load_B)
                shift[N:1] <= B;
            if(mult_control.load_add)
                shift[2*N:N+1] <= adder_sub_out;
        end
    end
endmodule

