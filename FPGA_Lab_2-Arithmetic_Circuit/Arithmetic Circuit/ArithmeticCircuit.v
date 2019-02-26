module ArithmeticCircuit(A, B, S1, S2, Cin, Cout, F);
input [3:0] A, B;
input S1, S2, Cin;
output Cout;
output[3:0] F;

reg [3:0] F;
reg Cout;


always @(*)
begin
	if (S1 == 0 && S2 == 0 && Cin == 0)
		{Cout,F} = A + B;
	if (S1 == 0 && S2 == 1 && Cin == 0)
		{Cout, F} = A + ~B;
	if (S1 == 1 && S2 == 0 && Cin == 0)
		{Cout, F} = ~A + B;
	if (S1 == 1 && S2 == 1 && Cin == 0)
		{Cout, F} = ~B;
	
	
	if (S1 == 0 && S2 == 0 && Cin == 1)
		{Cout, F} = A + B + 1;
	if (S1 == 0 && S2 == 1 && Cin == 1)
		{Cout, F} = A + ~B + 1;
	if (S1 == 1 && S2 == 0 && Cin == 1)
		{Cout, F} = ~A + B + 1;
	if (S1 == 1 && S2 == 1 && Cin == 1)
		{Cout, F} = ~B + 1;
end
	
endmodule