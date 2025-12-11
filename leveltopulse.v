module leveltopulse (
	input wire clk,    	// Clock do sistema
	input wire rst,    	// Reset ativo em nível alto
	input wire chave,  	// Entrada da chave
	output reg pulso   	// Saída do pulso
);

	// Registradores para sincronização e detecção de borda
	reg chave_sync1;
	reg chave_sync2;

	always @(posedge clk or posedge rst) begin
    	if (rst) begin
        	// Reset: inicializa os sinais
        	chave_sync1 <= 1'b0;
        	chave_sync2 <= 1'b0;
        	pulso <= 1'b0;
    	end
    	else begin
        	// Sincronização da entrada (evita metaestabilidade)
        	chave_sync1 <= chave;
        	chave_sync2 <= chave_sync1;
       	 
        	// Detecta borda de subida: chave_sync1 está em 1 e chave_sync2 está em 0
        	pulso <= chave_sync1 && !chave_sync2;
    	end
	end

endmodule
