module prescaler #(parameter COUNTER_SIZE = 1)(
input fast_clock, rst,
output reg slow_clock
);

 //formula es a=FRECLK/FRECDES, cntsize = log(a, 2)
localparam MAX_SIZE = 2**(COUNTER_SIZE)-1;

reg [COUNTER_SIZE-1:0] count;

always@(posedge fast_clock, negedge rst)
begin
	if(!rst)
		begin
			count <= 0;
			slow_clock <= 1'b0;
		end
	else
		begin
			if(count==MAX_SIZE)
				begin
					count <= 0;
					slow_clock <= 1'b1;
				end
			else
				begin
					count <= count + 1'b1;
					slow_clock <= 1'b0;
				end
		end
end
endmodule