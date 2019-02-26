module labFive( 
	output reg [6:0] Digi0, Digi1, Digi2, Digi3, // out to 7 segment 
	input PS2_CLK, PS2_DAT, // in -- clock/data 
	input [0:0] KEY // Reset
); 

wire newChar; 
wire [7:0] char; 
reg [7:0] lastChar, lastChar2;

receiver M1(.newChar(newChar), .char(char), .PS2_CLK(PS2_CLK), .PS2_DAT(PS2_DAT), .reset(!KEY[0])); 

always @ (posedge newChar or negedge KEY[0]) begin 
	if (!KEY[0]) begin 
		Digi0 = 7'b1111111; // OFF 
		Digi1 = 7'b1111111; // OFF 
		Digi2 = 7'b1111111; // OFF 
		Digi3 = 7'b1111111; // OFF 
end 

else if (char == 8'hF0) begin // display the last value

if (lastChar == 8'hE0) begin
	Digi2 = display_driver(lastChar[3:0]); 	
	Digi3 = display_driver(lastChar[7:4]); 
	Digi0 = display_driver(lastChar2[3:0]); 
	Digi1 = display_driver(lastChar2[7:4]); 
end 
else begin 
	Digi2 = Digi0; 
	Digi3 = Digi1; // Shift values
	Digi0 = display_driver(lastChar[3:0]); 
	Digi1 = display_driver(lastChar[7:4]); 
	end 
end 
else begin 
	lastChar2 = lastChar; // Save the char before last char 
	lastChar = char; // Save very last char 
end 
end 

function [6:0] display_driver; 
input [3:0] in; 
case (in) 
4'b0000 : display_driver = 7'b1000000; // 0 
4'b0001 : display_driver = 7'b1111001; // 1 
4'b0010 : display_driver = 7'b0100100; // 2 
4'b0011 : display_driver = 7'b0110000; // 3 
4'b0100 : display_driver = 7'b0011001; // 4 
4'b0101 : display_driver = 7'b0010010; // 5 
4'b0110 : display_driver = 7'b0000011; // 6 
4'b0111 : display_driver = 7'b1111000; // 7 
4'b1000 : display_driver = 7'b0000000; // 8 
4'b1001 : display_driver = 7'b0011000; // 9 
4'b1010 : display_driver = 7'b0001000; // A 
4'b1011 : display_driver = 7'b0000000; // B 
4'b1100 : display_driver = 7'b1000110; // C 
4'b1101 : display_driver = 7'b1000000; // D 
4'b1110 : display_driver = 7'b0000110; // E 
4'b1111 : display_driver = 7'b0001110; // F 
default : display_driver = 7'b1111111; // OFF 
endcase 
endfunction
endmodule