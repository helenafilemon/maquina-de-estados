module mef1 ( input clk , input g, input s, input rd, input reset, input back, input ev, output D, output Lerro, output LEV, output M);

reg [1:0] state , nextstate;
// state code
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;



// state register
always @ ( posedge clk , posedge
    reset )
    if ( reset ) state <= S0;
    else state <= nextstate;
// next state logic
always @ (*)
    case ( state )
        S0 : if ( ~g && ~s ) nextstate = S1;
        else nextstate = S0;
        S1 : if ( ev ) nextstate = S2;
        else nextstate = S1;
        S2 : if ( ~rd  ) nextstate = S3;
        else nextstate = S2;
        S3 : if ( back ) nextstate = S1;
        else nextstate = S3;
        default : nextstate = S0;
    endcase

// output logic
assign M = (~rd & s3 | ~rd & s2) | (ev & s1 | ev & s3) | (s3) | (~g & ~s & s0);
assign LEV = (~ev & s1);
assign Lerro = (rd & s2);
assign D = (s3);

assign s0= ~state[1] & ~state[0];
assign s1= ~state[1] & state[0];
assign s2= state[1] & ~state[0];
assign s3= state[1] & state[0];
endmodule








