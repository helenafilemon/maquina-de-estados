module mef2 (  input clk , input dn, input cqs, input cqn, input reset, output dec, output addg, output lixo, output reg back);

reg [1:0] state , nextstate;
// state code
parameter ESPERA = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

// state register
always @ ( posedge clk, posedge
    reset )
    if ( reset ) state <= ESPERA;
    else state <= nextstate;

// next state logic
always @ (*)
    case ( state )
        ESPERA : 
          begin
          if ( dn ) nextstate = S1;
           else nextstate = ESPERA;
            back = 1'b0;
            end
        S1 : if ( cqs ^ cqn ) nextstate = S2;
        else nextstate = S1;
        S2 : begin
            back = 1'b1;
            nextstate = ESPERA;
            end
        default : nextstate = ESPERA;
    endcase

// output logic
assign lixo = (cqn & s1 & ~cqs); // pinar led para dizer que descartou
assign addg = (cqs & s1 & ~cqn); //saida como clock para incrementar no contador +1
assign dec = (dn & s0); //saida para entrar no contador e decrementar ele.


assign s0= ~state[1] & ~state[0];
assign s1= ~state[1] & state[0];
assign s2= state[1] & ~state[0];
endmodule














