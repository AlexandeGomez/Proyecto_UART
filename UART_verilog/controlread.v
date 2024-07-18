module controlread(
input tickbd, rst, ticksend,
input txdone,

output reg [3:0] addr,
output reg txena
);

parameter IDLE = 0, ADDR = 1, COND = 2, REC = 3;

reg [1:0] state;
reg [2:0] cnt;

always@(posedge tickbd, negedge rst)
begin
	if(!rst)
		begin
		state <= IDLE;
		cnt <= 3'd0;
		end
	else
		begin
		case(state)
			IDLE:
				begin
				if(ticksend)
					begin
					state<=ADDR;
					end
				else
					begin
					state <= IDLE;
					txena <= 1'b0;
					end
				end
			ADDR:
				begin
				addr <= cnt;
				state <= COND;
				end
			COND:
				begin
				txena <= 1'b1;
				if(cnt==3'd5)
					begin
					cnt <= 3'd0;
					state <= IDLE;
					end
				else
					begin
					cnt <= cnt + 3'd1;
					state <= REC;
					end
				end
			REC:
				begin
				if(txdone)
					begin
					state <= ADDR;
					end
				else
					begin
					txena <= 1'b0;
					state <= REC;
					end
				end
		endcase
		end
end

endmodule
