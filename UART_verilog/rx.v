module rx #(parameter NBITS = 8, parameter NTICKB = 16)(
input	bdtick, rx_in, rx_rst,
	
output reg rx_done,
output reg [NBITS - 1 :0] rx_out 
);


localparam IDLE = 0, START = 1, DATA = 2, STOP = 3;
localparam MIDDLEB = 7;


reg [$clog2(NBITS) - 1 :0] i;
reg [$clog2(NTICKB) :0]		s;
reg [$clog2(NTICKB*2) :0] nstop;
reg [1:0] state;


always @ (posedge bdtick or negedge rx_rst) begin
	if (!rx_rst)
		state <= IDLE;
	else
		case (state)
			IDLE:
				//IDLE body
				if(!rx_in)
					begin
					s <= 0;
					i <= 0;
					nstop <= 0;
					rx_out <= 8'd0;
					rx_done <= 1'b0;
					state <= START;
					end
				else
					rx_done <= 1'b0;
			START:
				//IDLE body
				if(s==MIDDLEB)
				begin
					s <= 0;
					i <= 0;
					state <= DATA;
				end
				else
					s <= s + 1'b1;
			DATA:
				//IDLE body
				if(s==(NTICKB-1))
					begin
					s <= 0;
					rx_out[i] <= rx_in;
					if(i==(NBITS-1))
						begin
						state <= STOP;
						end
					else
						begin
						i <= i + 1'b1;
						end
					end
				else
					begin
					s <= s + 1'b1;
					end
			STOP:
				//IDLE body
				if(nstop==(NTICKB*2)-1)
					begin
						rx_done <= 1'b1;
						state <= IDLE;
					end
				else
					begin
						nstop <= nstop + 1'b1;
					end
		endcase
end

endmodule
