module muxtwoselfour(
//inputs
input ena,
input [1:0] sel,

//outputs
output reg selbaud, selmodtx, seltxff, seltx
);

parameter SELBAUD = 0, SELMODTX = 1, SELTXFF= 2, SELTX = 3;

always@(*)
begin
	if(!ena)
		case(sel)
			SELBAUD:
			begin
				selbaud = 1'b1;
				selmodtx = 1'b0;
				seltxff = 1'b0;
				seltx = 1'b0;
			end
			SELMODTX:
			begin
				selbaud = 1'b0;
				selmodtx = 1'b1;
				seltxff = 1'b0;
				seltx = 1'b0;
			end
			SELTXFF:
			begin
				selbaud = 1'b0;
				selmodtx = 1'b0;
				seltxff = 1'b1;
				seltx = 1'b0;
			end
			SELTX:
			begin
				selbaud = 1'b0;
				selmodtx = 1'b0;
				seltxff = 1'b0;
				seltx = 1'b1;
			end
		endcase
	else
		begin
			selbaud = 1'b0;
			selmodtx = 1'b0;
			seltxff = 1'b0;
			seltx = 1'b0;
		end
end

endmodule
