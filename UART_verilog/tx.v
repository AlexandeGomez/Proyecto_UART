module tx #(parameter NBITS = 8, parameter NTICK = 16)(
//inputs
input	bdtick, tx_ena, tx_rst, txff_ena,
input [NBITS - 1 :0] data_in,

//outputs
output reg  tx_out, tx_done
);


	// PARAMETROS
localparam IDLE = 0, START = 1, DATA = 2, STOP = 3; // estados
// NBITS Numero de bits del valor a transmitir
// NTICK Numero de ticks por bit de información
	
	// VARIABLES DE ENTORNO
reg [$clog2(NBITS)    :0] i;
reg [$clog2(NTICK)   :0] s;
reg [$clog2(NTICK*2)   :0] nstop;
reg [1:0] state;
reg [NBITS - 1 :0] datareg;


	// SALIDAS DE CADA ESTADO
always @ (state, i) begin
	case (state)
		IDLE:
			tx_out = 1'b1;
		START:
			tx_out = 1'b0;
		DATA:
			tx_out = datareg[i];
		STOP:
			tx_out = 1'b1;
	endcase
end


	//LOGICA DE CAMBIO DE ESTADOS
always@(posedge bdtick, negedge tx_rst) 
begin
	if (!tx_rst)
	begin
		state <= IDLE;
	end
	else
	begin
		case (state)
			IDLE:
				// IDLE BODY
				if(tx_ena || txff_ena)
				begin
					s <= 0;
					i <= 0;
					nstop <= 0;
					tx_done <= 1'b0;
					datareg <= data_in;
					state <= START;
				end
				else
				begin
					tx_done <= 1'b0;
				end
			START:
				//START BODY
				if(s==NTICK - 1)
				begin
					s <= 0;
					state <= DATA;
				end
				else
				begin
					s <= s + 1'b1;
				end
			DATA:
				//DATA BODY
				if(s==NTICK-1)
				begin
					if(i==NBITS-1)
						state <= STOP;
					else
						s <= 0;
						i <= i + 1'b1;
				end
				else
				begin
					s <= s + 1'b1;
				end
			STOP:
				//STOP BODY
				if(nstop==(NTICK*2)-1)
				begin
					tx_done <= 1'b1;
					state <= IDLE;
				end
				else
					nstop <= nstop + 1'b1;
		endcase
	end
end

endmodule
