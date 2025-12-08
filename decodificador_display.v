module decodificador_display(
	input [7:0] entrada,
	output [6:0] display_U, // segmentos p/ a unidade 
	output [6:0] display_D  // segmentos p/ a dezena
);

	wire [3:0] valor_unidade;
	wire [3:0] valor_dezena;

	// separação dos dígitos
	// % pega o resto da divisão (U)
	// / faz a divisão inteira (D)
	assign valor_unidade = entrada % 10; 
	assign valor_dezena  = (entrada / 10) % 10; 

	// converte o valor da unidade para os segmentos
	conversor_7seg conv_u (
	  .valor(valor_unidade),
	  .segmentos(display_U)
	);

	// converte o valor da dezena para os segmentos
	conversor_7seg conv_d (
	  .valor(valor_dezena),
	  .segmentos(display_D)
	);

endmodule

// converte número de 4 bits (0-9) para 7 segmentos
module conversor_7seg(
	input [3:0] valor,
	output reg [6:0] segmentos 
);

	always @(*) begin
		case(valor)
			4'd0: segmentos = 7'b0111111; // 0
			4'd1: segmentos = 7'b0000110; // 1
			4'd2: segmentos = 7'b1011011; // 2
			4'd3: segmentos = 7'b1001111; // 3
			4'd4: segmentos = 7'b1100110; // 4
			4'd5: segmentos = 7'b1101101; // 5
			4'd6: segmentos = 7'b1111101; // 6
			4'd7: segmentos = 7'b0000111; // 7
			4'd8: segmentos = 7'b1111111; // 8
			4'd9: segmentos = 7'b1101111; // 9
			default: segmentos = 7'b0000000; // desliga se for erro (>9)
		endcase
	end
endmodule