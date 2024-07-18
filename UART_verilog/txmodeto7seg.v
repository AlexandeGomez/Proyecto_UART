module txmodeto7seg(
input cntmodetx,

output reg [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);


always@(*)
begin
	case(cntmodetx)
		1:
			begin
			HEX0 <= 8'b1_0001_110; //F
			HEX1 <= 8'b1_0001_110; //F
			HEX2 <= 8'b1_1111_111; //NONE
			HEX3 <= 8'b1_1111_111; //NONE
			HEX4 <= 8'b1_1111_111; //NONE
			HEX5 <= 8'b1_1111_111; //NONE
			end
		0:
			begin
			HEX0 <= 8'b1_1000_110; //C
			HEX1 <= 8'b1_0010_010; //S
			HEX2 <= 8'b1_1111_111; //NONE
			HEX3 <= 8'b1_1111_111; //NONE
			HEX4 <= 8'b1_1111_111; //NONE
			HEX5 <= 8'b1_1111_111; //NONE
			end
		endcase
end

endmodule
