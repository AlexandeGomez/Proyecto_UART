module modetxselect(
input selmodtx, ticksel, rst,
input [7:0] datainsw,
input [7:0] datainff,

output [7:0] dataintx,
output reg cnt
);


always@(posedge ticksel, negedge rst)
begin
	if(!rst)
		begin
		cnt <= 1'b0;
		end
	else
		if(selmodtx)
			begin
			cnt <= ~cnt;
			end
end

assign dataintx = (cnt==1'b0)? datainsw : datainff;

endmodule
