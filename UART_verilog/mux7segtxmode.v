module mux7segtxmode(
input	[7:0] HEXBD0,
input	[7:0] HEXBD1,
input	[7:0] HEXBD2,
input	[7:0] HEXBD3,
input	[7:0] HEXBD4, 
input	[7:0] HEXBD5,
	
input	[7:0] HEXTM0,
input	[7:0] HEXTM1,	
input	[7:0] HEXTM2,
input	[7:0] HEXTM3,
input	[7:0] HEXTM4,
input	[7:0] HEXTM5,

input	[7:0] HEXCD0,
input	[7:0] HEXCD1,	
input	[7:0] HEXCD2,
input	[7:0] HEXCD3,
input	[7:0] HEXCD4,
input	[7:0] HEXCD5,

input	[1:0] sel,

output reg [7:0] HEX0,
output reg [7:0] HEX1,
output reg [7:0] HEX2,
output reg [7:0] HEX3,
output reg [7:0] HEX4,
output reg [7:0] HEX5
);

always@(*)
begin
	case(sel)
		2'd0:
			begin
			 HEX0 <= HEXBD0;
			 HEX1 <= HEXBD1;
			 HEX2 <= HEXBD2;
			 HEX3 <= HEXBD3;
			 HEX4 <= HEXBD4;
			 HEX5 <= HEXBD5;
			end
		2'd1:
			begin
			 HEX0 <= HEXTM0;
			 HEX1 <= HEXTM1;
			 HEX2 <= HEXTM2;
			 HEX3 <= HEXTM3;
			 HEX4 <= HEXTM4;
			 HEX5 <= HEXTM5;
			end
		2'd2:
			begin
			 HEX0 <= HEXCD0;
			 HEX1 <= HEXCD1;
			 HEX2 <= HEXCD2;
			 HEX3 <= HEXCD3;
			 HEX4 <= HEXCD4;
			 HEX5 <= HEXCD5;
			end
		default:
			begin
			 HEX0 <= 8'd255;
			 HEX1 <= 8'd255;
			 HEX2 <= 8'd255;
			 HEX3 <= 8'd255;
			 HEX4 <= 8'd255;
			 HEX5 <= 8'd255;
			end
	endcase
end


endmodule
