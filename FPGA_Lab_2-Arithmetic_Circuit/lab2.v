module mux2_M0(W0,~A,S1);
input S1;
input[3:0] ~A;
output[3:0] W0;
assign W0 = S1 ? ~A:0;

endmodule;

module mux2_M1(W1, A, W0, S0);
input S0;
input [3:0] A, W0;
output [3:0] W1;
assign W1 = S0 ? A: W0;

endmodule;

module mux4(W1,A,~A,O,S0,S1);
output W1;
input A,~A, O, S0,S1;

mux2_M0(W0,~A,O,S1);
mux2_M1(W1, A, W0, S0);

endmodule;

module mux2_M2(W2, B, ~B, S0);
input S0;
input [3:0] B, ~B; 
output [3:0] W2;
assign W2 = S0 ? B:~B;

endmodule;

module Add_half1(W3, W4, W1, W2);
input [3:0] W1, W2;
output [3:0] W3, W4;
xor (W3, W1, W2);
and (W4, W1, W2);
endmodule;

module Add_half2(F, W5, CIN, W3);
input [3:0] CIN, W3;
output [3:0] F, W5;
xor (F, CIN, W3);
and (W5, CIN, W3);
endmodule;

module full_add(F, CO, W1, W2, CIN)

input [3:0] W1, W2, CIN;
output [3:0] F, CO;
wire W1, W2, W3, W4, W5;

Add_half1(W3, W4, W1, W2);
Add_half2(F, W5, CIN, W3);
or(CO, W5, W4);
endmodule;

module testbench();

reg [3:0] A;
reg [3:0] B;
reg S0;
reg S1;
reg CIN;

wire [3:0] F;
wire CO;

full_add(F, CO, W1, W2, CIN);
mux4(W1,A,~A,O,S0,S1);
mux2_M2(W2, B, ~B, S0);

inital
begin
#10 CIN=0 ; S0=0; S1=0; A=0; B=0;
#10 CIN=0 ; S0=0; S1=0; A=0; B=1;
#10 CIN=0 ; S0=0; S1=0; A=1; B=0;
#10 CIN=0 ; S0=0; S1=0; A=1; B=1;
#10 CIN=0 ; S0=0; S1=1; A=0; B=0;
#10 CIN=0 ; S0=0; S1=1; A=0; B=1;
#10 CIN=0 ; S0=0; S1=1; A=1; B=0;
#10 CIN=0 ; S0=0; S1=1; A=1; B=1;
#10 CIN=0 ; S0=1; S1=0; A=0; B=0;
#10 CIN=0 ; S0=1; S1=0; A=0; B=1;
#10 CIN=0 ; S0=1; S1=0; A=1; B=0;
#10 CIN=0 ; S0=1; S1=0; A=1; B=1;
#10 CIN=0 ; S0=1; S1=1; A=0; B=0;
#10 CIN=0 ; S0=1; S1=1; A=0; B=1;
#10 CIN=0 ; S0=1; S1=1; A=1; B=0;
#10 CIN=0 ; S0=1; S1=1; A=1; B=1;
#10 CIN=1 ; S0=0; S1=0; A=0; B=0;
#10 CIN=1 ; S0=0; S1=0; A=0; B=1;
#10 CIN=1 ; S0=0; S1=0; A=1; B=0;
#10 CIN=1 ; S0=0; S1=0; A=1; B=1;
#10 CIN=1 ; S0=0; S1=1; A=0; B=0;
#10 CIN=1 ; S0=0; S1=1; A=0; B=1;
#10 CIN=1 ; S0=0; S1=1; A=1; B=0;
#10 CIN=1 ; S0=0; S1=1; A=1; B=1;
#10 CIN=1 ; S0=1; S1=0; A=0; B=0;
#10 CIN=1 ; S0=1; S1=0; A=0; B=1;
#10 CIN=1 ; S0=1; S1=0; A=1; B=0;
#10 CIN=1 ; S0=1; S1=0; A=1; B=1;
#10 CIN=1 ; S0=1; S1=1; A=0; B=0;
#10 CIN=1 ; S0=1; S1=1; A=0; B=1;
#10 CIN=1 ; S0=1; S1=1; A=1; B=0;
#10 CIN=1 ; S0=1; S1=1; A=1; B=1;

end;
endmodule;

