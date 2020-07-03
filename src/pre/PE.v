module PE(aq, M, AQ);

parameter width = 8;

input  [2*width-1:0] aq;
input  [  width-1:0] M;
output [2*width-1:0] AQ;

wire sel;
reg [2*width-1:0] AQ;

assign sel = aq[15] ? 0 : 1;

always @(*) begin
	AQ = aq << 1;
	AQ = sel ? {AQ[2*width-1:width] - M, AQ[width-1:0]} : {AQ[2*width-1:width] + M, AQ[width-1:0]}; 
	AQ[0] = AQ[15] ? 0 : 1;
end

endmodule
