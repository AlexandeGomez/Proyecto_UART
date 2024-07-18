module baudselect(
input selbaud, ticksel, rst,

output [8:0] refer
);

parameter MAXCNT = 2;

reg [1:0] cnt;

always@(posedge ticksel, negedge rst)
begin
	if(!rst)
		begin
		cnt <= 2'd0;
		end
	else
		if(selbaud)
			begin
			if(cnt == MAXCNT)
				cnt <= 0;
			else
				cnt <= cnt + 2'd1;
			end
end

assign refer = (cnt==2'd0)? 9'd324:
					(cnt==2'd1)? 9'd53:
					(cnt==2'd2)? 9'd26:
					9'd324;

endmodule
