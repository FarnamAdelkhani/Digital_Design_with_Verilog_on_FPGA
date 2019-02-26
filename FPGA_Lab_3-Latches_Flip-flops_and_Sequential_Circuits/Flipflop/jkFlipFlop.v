module jkFlipFlop (J, K, CLK, Q);
  input J, K, CLK;
  output Q;
  
  reg Q;
  
  initial
    begin
      Q = 0;
  end
  
  always @ (posedge CLK)
  begin
    case ({J, K})
      {1'b0, 1'b0}:
      begin
        Q = Q;
      end
      
      {1'b0, 1'b1}:
      begin
        Q = 0;
      end
      
      {1'b1, 1'b0}:
      begin
        Q = 1;
      end
      
      {1'b1, 1'b1}:
      begin
        Q = ~Q;
      end
    endcase
  end
endmodule