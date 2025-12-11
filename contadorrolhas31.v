module contadorrolhas31 (
	input clk,
	input reset,    	// Reset: volta para o valor inicial (31)
	input decr_en,  	// Enable Decremento: diminui 1
	input incr_en,  	// Enable Incremento: aumenta 1
    
	output reg [4:0] q, // Saída de 5 bits (0 a 31)
	output erro_flag	// Avisa se chegou em 14
);

    
	leveltopulse M1(
    	.chave(incr_en),
    	.clk(clk),
    	.pulso(wincr)
	);
    
	// Parâmetros para facilitar ajustes
	localparam VALOR_INICIAL = 5'd31; // Começa cheio
	localparam MAX_VALOR 	= 5'd31; // Teto máximo (11111)
 	wire wincr;
 

	always @(posedge clk or posedge reset) begin
    	if (reset) begin
        	q <= VALOR_INICIAL;
    	end
    	else begin
        	// PRIORIDADE: Vamos definir que se apertar os dois, nada acontece (trava)
       	 
        	// Lógica de DECREMENTO (Só se não estiver tentando incrementar)
        	if (decr_en && !wincr) begin
            	if (q > 0)      	// Proteção contra Underflow (0 -> 31)
                	q <= q - 1'b1;
        	end
       	 
        	// Lógica de INCREMENTO (Só se não estiver tentando decrementar)
        	else if (wincr && !decr_en) begin
            	if (q < MAX_VALOR)  // Proteção contra Overflow (31 -> 0)
                	q <= q + 1'b1;
        	end
       	 
        	// Se ambos forem 0 ou ambos forem 1, mantém o valor (q <= q)
    	end
	end
 	and (erro_flag, ~q[0], q[1], q[2], q[3], ~q[4]);
 	
	 

endmodule





