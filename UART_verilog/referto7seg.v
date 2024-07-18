module referto7seg(
input	[8:0] refer,

output reg [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

localparam BD9600 = 324, BD57600 = 53, BD115200 = 26;

always@(*)
begin
	case(refer)
		BD9600:
			begin
			HEX0 <= 8'b1_1000_000; //0
			HEX1 <= 8'b1_1000_000; //0
			HEX2 <= 8'b1_0000_010; //6
			HEX3 <= 8'b1_0011_000; //9
			HEX4 <= 8'b1_1111_111; //NONE
			HEX5 <= 8'b1_1111_111; //NONE
			end
		BD57600:
			begin
			HEX0 <= 8'b1_1000_000; //0
			HEX1 <= 8'b1_1000_000; //0
			HEX2 <= 8'b1_0000_010; //6
			HEX3 <= 8'b1_1111_000; //7
			HEX4 <= 8'b1_0010_010; //5
			HEX5 <= 8'b1_1111_111; //NONE
			end
		BD115200:
			begin
			HEX0 <= 8'b1_1000_000; //0
			HEX1 <= 8'b1_1000_000; //0
			HEX2 <= 8'b1_0100_100; //2
			HEX3 <= 8'b1_0010_010; //5
			HEX4 <= 8'b1_1111_001; //1
			HEX5 <= 8'b1_1111_001; //1
			end
		default:
			begin
			HEX0 <= 8'b1_1111_111; //NONE
			HEX1 <= 8'b1_1111_111; //NONE
			HEX2 <= 8'b1_1111_111; //NONE
			HEX3 <= 8'b1_1111_111; //NONE
			HEX4 <= 8'b1_1111_111; //NONE
			HEX5 <= 8'b1_1111_111; //NONE
			end
		endcase
end


endmodule
