module testJK();
  
  wire Q, Qbar;
  reg J, K, CLK;
  
  jkFlipFlop jk(J, K, CLK, Q, Qbar);
  
  initial
  begin
    #10 CLK = 0; J = 1; K = 1;
    #10 CLK = 1; J = 1; K = 1;
    #10 CLK = 0; J = 0; K = 0;
    #10 CLK = 1; J = 0; K = 0;
    #10 CLK = 0; J = 1; K = 0;
    #10 CLK = 1; J = 1; K = 0;
    #10 CLK = 0; J = 0; K = 1;
    #10 CLK = 1; J = 0; K = 1;
    #10 CLK = 0; J = 1; K = 0;
    #10 CLK = 1; J = 1; K = 0;
    #10 CLK = 0; J = 1; K = 1;
    #10 CLK = 1; J = 1; K = 1;
    
    #10 CLK = 0; J = 0; K = 0;
    #10 CLK = 1; J = 0; K = 0;
    #10 CLK = 0; J = 0; K = 1;
    #10 CLK = 1; J = 0; K = 1;
    #10 CLK = 0; J = 1; K = 0;
    #10 CLK = 1; J = 1; K = 0;
    #10 CLK = 0; J = 1; K = 0;
    #10 CLK = 1; J = 1; K = 0;
    #10 CLK = 0; J = 1; K = 1;
    #10 CLK = 1; J = 1; K = 1;
    
    #10 CLK = 0; J = 0; K = 0;
    #10 CLK = 1; J = 0; K = 0;
    #10 CLK = 0; J = 1; K = 1;
    #10 CLK = 1; J = 1; K = 1;
    #10 CLK = 0; J = 0; K = 1;
    #10 CLK = 1; J = 0; K = 1;
    #10 CLK = 0; J = 1; K = 0;
    #10 CLK = 1; J = 1; K = 0;
    #10 CLK = 0; J = 1; K = 1;
    #10 CLK = 1; J = 1; K = 1;
  end
endmodule