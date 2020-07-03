`timescale 1ns / 10ps
//`include "PE.v"
module div(out, in1, in2, dbz);
parameter width = 8;
input  	[width-1:0] in1; // Dividend
input  	[width-1:0] in2; // Divisor
output  [width-1:0] out; // Quotient
output dbz;


/********************************

You need to write your code at here

********************************/

wire [2*width-1:0] q [0: width];
reg [width-1:0] out;
reg [1:0] sel;


assign dbz = in2  ? 0 : 1;
assign q[0] = {8'b0, in1};

always @(*) begin
	if (in1 == in2)
		sel = 2'b11;
	else if(in1<in2)
		sel = 2'b10;
	else if(in1 > in2 && in2 >= 130)
		sel = 2'b01;
	else sel = 2'b00;
end

PE pe0(q[0], in2, q[1]);
PE pe1(q[1], in2, q[2]);
PE pe2(q[2], in2, q[3]);
PE pe3(q[3], in2, q[4]);
PE pe4(q[4], in2, q[5]);
PE pe5(q[5], in2, q[6]);
PE pe6(q[6], in2, q[7]);
PE pe7(q[7], in2, q[8]);

always @(*) begin
	case(sel)
		2'b00: out = q[8][width-1:0];
		2'b01: out = 8'b00000001;
		2'b10: out = 8'b0;
		2'b11: out = 8'b00000001;
		default: out = q[8][width-1:0];
	endcase
end
endmodule
