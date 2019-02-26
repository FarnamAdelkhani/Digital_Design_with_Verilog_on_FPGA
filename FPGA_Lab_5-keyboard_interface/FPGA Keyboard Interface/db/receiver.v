module receiver( 
		output reg newChar,
		output reg[7:0] char, 
		input PS2_CLK, PS2_DAT, reset 
); reg[3:0] bitPos; // Current bit position in transmission 
wire parityCheck; 

xor M1(parityCheck, char[0], char[1], char[2], char[3], char[4], char[5], char[6], char[7]); 

	always @ (negedge PS2_CLK) 
	begin 
		newChar = 0; 
		if (reset) bitPos = 0; // Reset bit position 
		else if (bitPos == 0 & PS2_DAT == 0) bitPos = 1; // Check start bit 
	else if (bitPos >= 1 & bitPos <= 8) begin 
		char[bitPos - 1] = PS2_DAT; 
		bitPos = bitPos + 1'd1; 
	end 
	else if (bitPos == 9) begin // Check parity 
		if (PS2_DAT == ~parityCheck) 
			bitPos = 10; // Go to stop bit state 
		else 
			bitPos = 0; // Error in transmission 
end 
else if (bitPos == 10 & PS2_DAT == 1) begin // Check stop bit 
	newChar = 1; 
	bitPos = 0;
end 
else bitPos = 0; // If everything fails, then there must be an error in the transmission 
end 

endmodule 
