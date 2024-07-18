module baudgenerator(
input clk, rst,
input [8:0] refer,

output reg tickbd
);


reg [8:0] cnt;

always@(posedge clk, negedge rst)
begin
	if(!rst)
		cnt <= 9'd0;
	else
		begin
		if(cnt >= refer)
			begin
			tickbd <= 1'b1;
			cnt <= 9'd0;
			end
		else
			begin
			tickbd <= 1'b0;
			cnt <= cnt + 9'd1;
			end
		end
end

endmodule
