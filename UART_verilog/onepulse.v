module onepulse(
input tickbd, ticksel, ena,

output reg flag
);


always@(posedge tickbd, posedge ticksel)
begin
	if(ticksel==1'b1)
		begin
		if(ena)
			flag <= 1'b1;
		else
			flag <= 1'b0;
		end
	else
		flag <= 1'b0;
end

endmodule
