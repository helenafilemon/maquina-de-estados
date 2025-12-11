// Conversor de 5 bits binário para decimal em displays de 7 segmentos
// Entrada: número de 5 bits (0-31)
// Saída: Dezena e Unidade em displays de 7 segmentos

module decodificador_display (
    input [4:0] A,      // Entrada de 5 bits (0 a 31)
    output [6:0] U,     // Display unidade
    output [6:0] D      // Display dezena
);
    
    wire [3:0] FU, FD;  // BCD das unidades e dezenas
    
    // Converte binário (5 bits) para BCD
    decodificador5bit (.A(A), .U(FU), .D(FD));
    
    // Display das Unidades
    display (.A(FU), .a(U[0]), .b(U[1]), .c(U[2]), .d(U[3]), .e(U[4]), .f(U[5]), .g(U[6]));
    
    // Display das Dezenas
    display (.A(FD), .a(D[0]), .b(D[1]), .c(D[2]), .d(D[3]), .e(D[4]), .f(D[5]), .g(D[6]));
    
endmodule


// Display de 7 segmentos (decodificador BCD para 7 segmentos)
// Mantém a lógica original com portas AND/OR
module display (
    input [3:0] A,
    output a, b, c, d, e, f, g
);
    
    wire [3:0] Fa, Fb, Fd, Ff;
    wire [2:0] Fc, Fe, Fg;
    wire notA3, notA2, notA1, notA0;
    
    not (notA3, A[3]);
    not (notA2, A[2]);
    not (notA1, A[1]);
    not (notA0, A[0]);
    
    // Segmento a
    and (Fa[0], notA3, notA2, notA1, A[0]);
    and (Fa[1], notA3, A[2], notA1, notA0);
    and (Fa[2], A[3], notA2, A[1], A[0]);
    and (Fa[3], A[3], A[2], notA1, A[0]);
    or (a, Fa[0], Fa[1], Fa[2], Fa[3]);
    
    // Segmento b
    and (Fb[0], notA3, A[2], notA1, A[0]);
    and (Fb[1], A[2], A[1], notA0);
    and (Fb[2], A[3], A[1], A[0]);
    and (Fb[3], A[3], A[2], notA0);
    or (b, Fb[0], Fb[1], Fb[2], Fb[3]);
    
    // Segmento c
    and (Fc[0], notA3, notA2, A[1], notA0);
    and (Fc[1], A[3], A[2], notA0);
    and (Fc[2], A[3], A[2], A[1]);
    or (c, Fc[0], Fc[1], Fc[2]);
    
    // Segmento d
    and (Fd[0], notA3, notA2, notA1, A[0]);
    and (Fd[1], notA3, A[2], notA1, notA0);
    and (Fd[2], A[3], notA2, A[1], notA0);
    and (Fd[3], A[2], A[1], A[0]);
    or (d, Fd[0], Fd[1], Fd[2], Fd[3]);
    
    // Segmento e
    and (Fe[0], notA3, A[0]);
    and (Fe[1], notA2, notA1, A[0]);
    and (Fe[2], notA3, A[2], notA1);
    or (e, Fe[0], Fe[1], Fe[2]);
    
    // Segmento f
    and (Ff[0], notA3, notA2, A[0]);
    and (Ff[1], notA3, notA2, A[1]);
    and (Ff[2], notA3, A[1], A[0]);
    and (Ff[3], A[3], A[2], notA1, A[0]);
    or (f, Ff[0], Ff[1], Ff[2], Ff[3]);
    
    // Segmento g
    and (Fg[0], A[3], A[2], notA1, notA0);
    and (Fg[1], notA3, A[2], A[1], A[0]);
    and (Fg[2], notA3, notA2, notA1);
    or (g, Fg[0], Fg[1], Fg[2]);

endmodule


// Decodificador binário (5 bits) para BCD
module decodificador5bit (
    input [4:0] A,      // Entrada de 5 bits (0-31)
    output [3:0] U,     // Unidades (BCD)
    output [3:0] D      // Dezenas (BCD)
);
    
    reg [3:0] unidades;
    reg [3:0] dezenas;
    
    always @(*) begin
        // Conversão direta de binário para BCD decimal
        case(A)
            5'd0:  begin dezenas = 4'd0; unidades = 4'd0; end
            5'd1:  begin dezenas = 4'd0; unidades = 4'd1; end
            5'd2:  begin dezenas = 4'd0; unidades = 4'd2; end
            5'd3:  begin dezenas = 4'd0; unidades = 4'd3; end
            5'd4:  begin dezenas = 4'd0; unidades = 4'd4; end
            5'd5:  begin dezenas = 4'd0; unidades = 4'd5; end
            5'd6:  begin dezenas = 4'd0; unidades = 4'd6; end
            5'd7:  begin dezenas = 4'd0; unidades = 4'd7; end
            5'd8:  begin dezenas = 4'd0; unidades = 4'd8; end
            5'd9:  begin dezenas = 4'd0; unidades = 4'd9; end
            5'd10: begin dezenas = 4'd1; unidades = 4'd0; end
            5'd11: begin dezenas = 4'd1; unidades = 4'd1; end
            5'd12: begin dezenas = 4'd1; unidades = 4'd2; end
            5'd13: begin dezenas = 4'd1; unidades = 4'd3; end
            5'd14: begin dezenas = 4'd1; unidades = 4'd4; end
            5'd15: begin dezenas = 4'd1; unidades = 4'd5; end
            5'd16: begin dezenas = 4'd1; unidades = 4'd6; end
            5'd17: begin dezenas = 4'd1; unidades = 4'd7; end
            5'd18: begin dezenas = 4'd1; unidades = 4'd8; end
            5'd19: begin dezenas = 4'd1; unidades = 4'd9; end
            5'd20: begin dezenas = 4'd2; unidades = 4'd0; end
            5'd21: begin dezenas = 4'd2; unidades = 4'd1; end
            5'd22: begin dezenas = 4'd2; unidades = 4'd2; end
            5'd23: begin dezenas = 4'd2; unidades = 4'd3; end
            5'd24: begin dezenas = 4'd2; unidades = 4'd4; end
            5'd25: begin dezenas = 4'd2; unidades = 4'd5; end
            5'd26: begin dezenas = 4'd2; unidades = 4'd6; end
            5'd27: begin dezenas = 4'd2; unidades = 4'd7; end
            5'd28: begin dezenas = 4'd2; unidades = 4'd8; end
            5'd29: begin dezenas = 4'd2; unidades = 4'd9; end
            5'd30: begin dezenas = 4'd3; unidades = 4'd0; end
            5'd31: begin dezenas = 4'd3; unidades = 4'd1; end
            default: begin dezenas = 4'd0; unidades = 4'd0; end
        endcase
    end
    
    assign U = unidades;
    assign D = dezenas;
    
endmodule
