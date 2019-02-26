module t_receiver; 
wire newChar; 
wire [7:0] char; 
reg PS2_CLK, PS2_DAT, reset; 
receiver M1(.newChar(newChar), .char(char), .PS2_CLK(PS2_CLK), .PS2_DAT(PS2_DAT), .reset(reset)); 
initial begin PS2_CLK = 1; 
reset = 0; // Set initial values 

end 

always #5 PS2_CLK = !PS2_CLK; // Generate clk signal 

always begin 

reset = 1; 
#10 reset = 0; 
PS2_DAT = 0; // Start bit 
#10 PS2_DAT = 1; // D0 
#10 PS2_DAT = 0; // D1 
#10 PS2_DAT = 1; // D2 
#10 PS2_DAT = 0; // D3 
#10 PS2_DAT = 1; // D4 
#10 PS2_DAT = 0; // D5 
#10 PS2_DAT = 1; // D6 
#10 PS2_DAT = 0; // D7 
#10 PS2_DAT = 1; // Parity bit 
#10 PS2_DAT = 1; // Stop bit 
#10 $stop; 
end 
endmodule