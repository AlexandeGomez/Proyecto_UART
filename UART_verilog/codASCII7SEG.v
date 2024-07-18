module codASCII7SEG(
input [7:0] datain,
input datadone,

output reg [7:0] dataout
);

// 64 - 90

always@(posedge datadone)
begin
	case(datain)
		8'd65:
			dataout <= 8'b1_0001_000;
		8'd66:
			dataout <= 8'b1_0000_011;
		8'd67:
			dataout <= 8'b1_1000_110;
		8'd68:
			dataout <= 8'b1_0100_001;
		8'd69:
			dataout <= 8'b1_0000_110;
		8'd70:
			dataout <= 8'b1_0001_110;
		8'd71:
			dataout <= 8'b1_0000_010;
		8'd72:
			dataout <= 8'b1_0001_011;
		8'd73:
			dataout <= 8'b1_1001_111;
		8'd74:
			dataout <= 8'b1_1100_001;
		8'd75:
			dataout <= 8'b1_0001_101;
		8'd76:
			dataout <= 8'b1_1000_111;
		8'd77:
			dataout <= 8'b1_0110_000;
		8'd78:
			dataout <= 8'b1_0110_011;
		8'd79:
			dataout <= 8'b1_0100_011;
		8'd80:
			dataout <= 8'b1_0001_100;
		8'd81:
			dataout <= 8'b1_0011_000;
		8'd82:
			dataout <= 8'b1_0101_111;
		8'd83:
			dataout <= 8'b1_0010_010;
		8'd84:
			dataout <= 8'b1_0000_111;
		8'd85:
			dataout <= 8'b1_1100_011;
		8'd86:
			dataout <= 8'b1_0111_011;
		8'd87:
			dataout <= 8'b1_0111_001;
		8'd88:
			dataout <= 8'b1_0001_001;
		8'd89:
			dataout <= 8'b1_0011_001;
		default:
			dataout <= 8'b1_0110_110;
	endcase
end



endmodule
