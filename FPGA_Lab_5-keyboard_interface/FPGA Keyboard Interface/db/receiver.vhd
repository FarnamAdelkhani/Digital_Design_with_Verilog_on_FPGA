module t_keyboard; 
wire [6:0] HEX0, HEX1, HEX2, HEX3; // 7-segment displays 
reg PS2_CLK, PS2_DAT; // The clock and data signals from the PS/2 device 
reg reset; // Used as reset signal 
keyboard M1(.PS2_CLK(PS2_CLK), .PS2_DAT(PS2_DAT), .KEY(reset), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3)); 
initial begin 
PS2_CLK = 1; reset = 1; // Set initial values 
end 

always #5 PS2_CLK = !PS2_CLK; // Generate clk signal 
// Test by releasing up arrow 
always begin 
reset = 0; 
#10 reset = 1; 

// Send 0x75 
PS2_DAT = 0; // Start bit 
#10 PS2_DAT = 1; // D0 
#10 PS2_DAT = 0; // D1 
#10 PS2_DAT = 1; // D2 
#10 PS2_DAT = 0; // D3 
#10 PS2_DAT = 1; // D4 
#10 PS2_DAT = 1; // D5 
#10 PS2_DAT = 1; // D6 
#10 PS2_DAT = 0; // D7 
#10 PS2_DAT = 0; // Parity bit 
#10 PS2_DAT = 1; // Stop bit 

// Send E0 
#50 PS2_DAT = 0; // Start bit 
#10 PS2_DAT = 0; // D0 
#10 PS2_DAT = 0; // D1 
#10 PS2_DAT = 0; // D2 
#10 PS2_DAT = 0; // D3 
#10 PS2_DAT = 0; // D4 
#10 PS2_DAT = 1; // D5 
#10 PS2_DAT = 1; // D6 
#10 PS2_DAT = 1; // D7 
#10 PS2_DAT = 0; // Parity bit 
#10 PS2_DAT = 1; // Stop bit 

// Send F0 
#50 PS2_DAT = 0; // Start bit 
#10 PS2_DAT = 0; // D0 
#10 PS2_DAT = 0; // D1 
#10 PS2_DAT = 0; // D2 
#10 PS2_DAT = 0; // D3 
#10 PS2_DAT = 1; // D4 
#10 PS2_DAT = 1; // D5 
#10 PS2_DAT = 1; // D6 
#10 PS2_DAT = 1; // D7 
#10 PS2_DAT = 1; // Parity bit 
#10 PS2_DAT = 1; // Stop bit 

#50 reset = 0; 
#10 $stop; 

end 
endmodule