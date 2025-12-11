module mefprincipal (input clk, input reset, input garrafa, input start, input sensorev, input aprovada,input reprovada, input incrementar, 
output LedErro, output LedEnchendo, output motor, output Leddescartou, output [6:0] UNR, output [6:0] DZR, output [6:0] DGARRAFAS );
 
 wire clocks;
 wire atvMEF1;
 wire atvMEF2;
 wire en_decrementar, rolhadisponivel, adicionarg;
 wire [4:0]numrolhas;
 wire [3:0]cont_duzias;
 wire [4:0] duziascont;

 divisor_frequencia (
    .clk(clk),
    .qfinal(clocks)
 );
 
 mef1 pb1 (
    .clk(clocks),
    .g(garrafa),
    .s(start),
    .rd(rolhadisponivel),
    .back(atvMEF1),
    .ev(sensorev),
    .D(atvMEF2),
    .Lerro(LedErro),
    .LEV(LedEnchendo),
    .M(motor),
    .reset(reset)
 );
 
 mef2 pb2(
    .clk (clocks),
    .dn (atvMEF2),
    .cqs (aprovada),
    .cqn (reprovada),
    .lixo (Leddescartou),
    .back (atvMEF1),
    .dec (en_decrementar),
    .addg(adicionarg),
    .reset (reset)
 );
 
 contadorrolhas31 CR (
    .clk(clocks),
    .incr_en(incrementar),
    .decr_en(en_decrementar),
    .erro_flag(rolhadisponivel),
    .q(numrolhas),
    .reset(reset)
 );
 
 contadorduzia CD (
    .clk(adicionarg),
    .cont_10_out(cont_duzias),
    .rst(reset)
 );

decodificador_display dsprolhas (
    .A(numrolhas),
    .U (UNR),
    .D(DZR)
);

assign duziascont = {1'b0, cont_duzias};

decodificador_display dspduzias (
    .A(duziascont),
    .U (DGARRAFAS)
);

endmodule 






