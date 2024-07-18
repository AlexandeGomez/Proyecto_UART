module controlwrite(
input clk, rst,
input [7:0] datain,
input rxdone,

output reg [2:0] addr,
output reg [7:0] dataout,
output reg we
);


reg [1:0] state;
reg [2:0] cnt;

parameter IDLE = 0, WE = 1, COND = 2;


always@(posedge clk, negedge rst)
begin
	if(!rst)
		begin
		state <= IDLE;
		cnt <= 3'd0;
		addr <= 0;
		dataout <= 0;
		we <= 0;
		end
	else
		begin
		case(state)
			IDLE:
				begin
				if(rxdone)
					begin
					addr <= cnt;
					dataout <= datain;
					we <= 0;
					state <= WE;
					end
				else
					state <= IDLE;
				end
			WE:
				begin
				we <= 1'b1;
				state <= COND;
				end
			COND:
				begin
				if(cnt==3'd5)
					begin
					cnt <= 3'd0;
					we <= 0;
					state <= IDLE;
					end
				else
					begin
					cnt <= cnt + 3'd1;
					we <= 0;
					state <= IDLE;
					end
				end
		endcase
		end
end

endmodule
