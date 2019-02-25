module multi(dig3, dig2, dig1, sw, btn);

	input [3:0] btn;
	input[2:0]sw;
	
	output [6:0] dig3, dig2, dig1;
	reg [6:0] dig3, dig2, dig1;
	
	always @ (sw or btn) begin;
	
	if (btn == 2) begin; // decimal 0 - 15
	dig3 =7'b0111101; // d
	case(sw)
		0: begin dig1 = 7'b1111110; dig2 = 7'b0000000; end
		1: begin dig1 = 7'b0110000; dig2 = 7'b0000000; end		
		2: begin dig1 = 7'b1101101; dig2 = 7'b0000000; end
		3: begin dig1 = 7'b1111001; dig2 = 7'b0000000; end
		4: begin dig1 = 7'b0110011; dig2 = 7'b0000000; end
		5: begin dig1 = 7'b1011011; dig2 = 7'b0000000; end 
		6: begin dig1 = 7'b0111111; dig2 = 7'b0000000; end
		7: begin dig1 = 7'b1110000; dig2 = 7'b0000000; end
		8: begin dig1 = 7'b1111111; dig2 = 7'b0000000; end
		9: begin dig1 = 7'b1110011; dig2 = 7'b0000000; end
		10: begin dig1 = 7'b0000000; dig2 = 7'b0110000; end
		11: begin dig1 = 7'b0110000; dig2 = 7'b0110000; end
		12: begin dig1 = 7'b1101101; dig2 = 7'b0110000; end
		13: begin dig1 = 7'b1111001; dig2 = 7'b0110000; end
		14: begin dig1 = 7'b0110011; dig2 = 7'b0110000; end
		15: begin dig1 = 7'b1011011; dig2 = 7'b0110000; end
	endcase
	end

	else if(btn == 4) begin //hexa
	dig3 = 7'b0010111; //h
	dig2 = 7'b0000000; //blank
	case(sw)
		0:dig1 = 7'b1111110;
		1:dig1 = 7'b0110000;		
		2:dig1 = 7'b1101101;
		3:dig1 = 7'b1111001;
		4:dig1 = 7'b0110011;
		5:dig1 = 7'b1011011;
		6:dig1 = 7'b0111111;
		7:dig1 = 7'b1110000;
		8:dig1 = 7'b1111111;
		9:dig1 = 7'b1110011;
		10:dig1 = 7'b1110111;
		11:dig1 = 7'b0011111;
		12:dig1 = 7'b1001111;
		13:dig1 = 7'b0111011;
		14:dig1 = 7'b1001111;
		15:dig1 = 7'b1000111;
	endcase
	end
	
	else if (btn == 1) begin //bcd
	dig3 = 7'b0011111; //b
	dig2 = 7'b0000000; //blank
	case(sw)
		0:dig1 = 7'b1111110;
		1:dig1 = 7'b0110000;	
		2:dig1 = 7'b1101101;
		3:dig1 = 7'b1111001;
		4:dig1 = 7'b0110011;
		5:dig1 = 7'b1011011;
		6:dig1 = 7'b0111111;
		7:dig1 = 7'b1110000;
		8:dig1 = 7'b1111111;
		9:dig1 = 7'b1110011;
		10:dig1 = 7'b1110011;
		11:dig1 = 7'b1110011;
		12:dig1 = 7'b1110011;
		13:dig1 = 7'b1110011;
		14:dig1 = 7'b1110011;
		15:dig1 = 7'b1110011;
	endcase
	end
	else begin
	dig1 = 7'b0000000;
	dig2 = 7'b0000000;
	dig3 = 7'b0000000;
	end
end
endmodule