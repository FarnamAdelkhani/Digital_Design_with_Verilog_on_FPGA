module Dlatch (G, D, Q, Q1);
input G, D;
output Q1, Q;

reg Q1, Q;

always @(D or G)
	if (G)
	  begin
	    Q <= D;
	    Q1 <= ~D;
	   end
endmodule
	