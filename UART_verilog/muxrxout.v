module muxrxout(
input [7:0] HEXIN,
input [2:0] addrwin,
input ena,

output reg [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

always@(ena)
begin
	case(addrwin)
		3'd0:
			begin
			HEX5 <= HEXIN;
			end
		3'd1:
			begin
			HEX4 <= HEXIN;
			end
		3'd2:
			begin
			HEX3 <= HEXIN;
			end
		3'd3:
			begin
			HEX2 <= HEXIN;
			end
		3'd4:
			begin
			HEX1 <= HEXIN;
			end
		3'd5:
			begin
			HEX0 <= HEXIN;
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