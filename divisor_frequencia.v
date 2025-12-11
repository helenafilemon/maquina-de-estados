module divisor_frequencia (
	input clk,
	output qfinal
	);
    
	wire[21:0] q;

	flipflopt ff1(clk, 1'b1, q[0]);
	flipflopt ff2(q[0], 1'b1, q[1]);
	flipflopt ff3(q[1], 1'b1, q[2]);
	flipflopt ff4(q[2], 1'b1, q[3]);
	flipflopt ff5(q[3], 1'b1, q[4]);
	flipflopt ff6(q[4], 1'b1, q[5]);
	flipflopt ff7(q[5], 1'b1, q[6]);
	flipflopt ff8(q[6], 1'b1, q[7]);
	flipflopt ff9(q[7], 1'b1, q[8]);
	flipflopt ff10(q[8], 1'b1, q[9]);
	flipflopt ff11(q[9], 1'b1, q[10]);
	flipflopt ff12(q[10], 1'b1, q[11]);
	flipflopt ff13(q[11], 1'b1, q[12]);
	flipflopt ff14(q[12], 1'b1, q[13]);
	flipflopt ff15(q[13], 1'b1, q[14]);
	flipflopt ff16(q[14], 1'b1, q[15]);
	flipflopt ff17(q[15], 1'b1, q[16]);
	flipflopt ff18(q[16], 1'b1, q[17]);
	flipflopt ff19(q[17], 1'b1, q[18]);
	flipflopt ff20(q[18], 1'b1, q[19]);
	flipflopt ff21(q[19], 1'b1, q[20]);
	flipflopt ff22(q[20], 1'b1, q[21]);
	flipflopt ff23(q[21], 1'b1, qfinal);

    
    
endmodule

module flipflopt(clk,t,q);
	input clk,t;
	output reg q;

	always @ (posedge clk)begin
     	if(t == 0)
          	q <= q;
     	else
          	q = ~q;
	end    	 
endmodule


