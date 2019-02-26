module bitTest();
  wire [1:0] Q;
  reg K, CLK, reset;
  
  bitCount count(K, CLK, reset, Q);
  
  initial
  begin
    #10 CLK = 0; K = 0; reset = 0;
    #10 CLK = 1; K = 0; reset = 0;
    #10 CLK = 0; K = 1; reset = 0;
    #10 CLK = 1; K = 1; reset = 0;
    #10 CLK = 0; K = 0; reset = 0;
    #10 CLK = 1; K = 0; reset = 0;
    #10 CLK = 0; K = 1; reset = 0;
    #10 CLK = 1; K = 1; reset = 0;
    
    #10 CLK = 0; K = 0; reset = 0;
    #10 CLK = 1; K = 0; reset = 0;
    #10 CLK = 0; K = 1; reset = 0;
    #10 CLK = 1; K = 1; reset = 1;
    #10 CLK = 0; K = 0; reset = 1;
    #10 CLK = 1; K = 0; reset = 0;
    #10 CLK = 0; K = 1; reset = 1;
    #10 CLK = 1; K = 1; reset = 1;
    #10 CLK = 1; K = 1; reset = 1;
    
    #10 CLK = 0; K = 0; reset = 0;
    #10 CLK = 1; K = 0; reset = 0;
    #10 CLK = 0; K = 1; reset = 0;
    #10 CLK = 1; K = 1; reset = 0;
    #10 CLK = 0; K = 0; reset = 0;
    #10 CLK = 1; K = 0; reset = 0;
    #10 CLK = 0; K = 1; reset = 0;
    #10 CLK = 1; K = 1; reset = 0;
    
    #10 CLK = 0; K = 0; reset = 0;
    #10 CLK = 1; K = 0; reset = 0;
    #10 CLK = 0; K = 1; reset = 1;
    #10 CLK = 1; K = 1; reset = 1;
    #10 CLK = 0; K = 0; reset = 1;
    #10 CLK = 1; K = 0; reset = 0;
    #10 CLK = 0; K = 1; reset = 0;
    #10 CLK = 1; K = 1; reset = 0;
    #10 CLK = 1; K = 1; reset = 0;
    
    #10 CLK = 0; K = 0; reset = 0;
    #10 CLK = 1; K = 0; reset = 1;
    #10 CLK = 0; K = 1; reset = 0;
    #10 CLK = 1; K = 1; reset = 0;
    #10 CLK = 0; K = 0; reset = 0;
    #10 CLK = 1; K = 0; reset = 0;
    #10 CLK = 0; K = 1; reset = 1;
    #10 CLK = 1; K = 1; reset = 1;
    #10 CLK = 1; K = 1; reset = 1;
  end
endmodule