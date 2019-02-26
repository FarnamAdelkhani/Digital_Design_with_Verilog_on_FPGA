module bitCount(K, CLK, reset, Q);
  input K;
  input CLK, reset;
  output [1:0] Q;

  jkFlipFlop flop1(~reset, K, CLK, Q[0]);
  jkFlipFlop flop2(~reset & Q[0] , reset | Q[0], CLK, Q[1]);
endmodule