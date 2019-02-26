module D_latch_behavior (G, D, Q, X);
input G, D;
output Q, X;

reg Q, X;

always @(D or G)
	begin
		Q <= D;
		X <= -D;
	end
endmodule
	