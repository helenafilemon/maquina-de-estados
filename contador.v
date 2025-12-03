module contador (
	input wire clk,
	input wire rst,
	output wire [3:0] cont_12_out,	// saída do contador de 12
	output wire [3:0] cont_10_out		// saída do contador de 10
);

	// liga o rollover ao enable
	wire pulso_para_contador;
	
	// instancia do contador de 12
	contador12 C1 (
		.clk(clk),
		.rst(rst),
		.rollover(pulso_para_contador),	// gera o plso
		.S(cont_12_out)
	);
	
	// instancia do contador de 10
	contador10 (
		.clk(clk),
		.rst(rst),
		.enable(pulso_para_contador),		// recebe o pulso como enable
		.S(cont_10_out)
	);
endmodule 

module contador10 (
	input wire clk,
	input wire rst,
	input wire enable, // só conta se o enable for 1
	output reg [3:0] S	// saída do contador
);

	// bloco sequencial acionado na borda e subida
	always @(posedge clk or posedge rst) begin
		if (rst) begin	// se o rst estivr ativo, zera o contador
			S <= 4'b0000;
		end else if (enable) begin	// apenas se o enable for 1
			if (S == 4'd9) begin	// chega em 10 -> volta pra zero
				S <= 4'b0000;
			end else begin
				S <= S + 1;	// incrementa 1
			end
		end
	end
endmodule

module contador12 (
	input wire clk,
	input wire rst,
	output wire rollover,	// sinal que incrementa o contador de 0-10
	output wire [3:0] S
);

	reg [3:0] cont_12;
	
	// o plso é gerado de forma combinacional, só fica 1 quando o contador é 11
	assign rollover = (cont_12 == 4'd11);
	assign S = cont_12;	// saída da contagem (0-11)
	
	always @(posedge clk or posedge rst) begin
		if (rst) begin	// rst zera a contagem
			cont_12 <= 4'b0000;
		end else begin
			if (rollover) begin	// se o contador estiverem 11
				cont_12 <= 4'b0000;	// zera o contador
			end else begin
				cont_12 <= cont_12 + 1;	// incrementa 1
			end
		end
	end
endmodule
