`timescale 1ns/1ns
module tb_dut();

reg clk_tb; 
reg rst_tb;
reg ena_tb;
reg [1:0] sel_tb;
reg enatb;
reg [7:0] dataintb;

wire txouttb;
wire tickbd_tb;
wire ticksel_tb;
wire selbaud_tb, selmodtx_tb, seltxff_tb, seltx_tb;
wire [8:0] refer_tb;
wire [7:0] rxout_tb;
wire rxdone_tb;
wire [2:0] addrcw_tb;
wire [7:0] dataoutcw_tb;
wire we_tb;
wire [7:0] q_tb;
wire flagff_tb;
wire txdone_tb;
wire [2:0] addrcr_tb;
wire txenacr_tb;
wire txout_tb;


tx #(.NBITS(8),	.NTICK(16)) TXTB(	
	.bdtick	(tickbd_tb), 
	.tx_ena	(enatb), 
	.tx_rst	(rst_tb), 
	.txff_ena(),
	.data_in	(dataintb),

	.tx_out	(txouttb), 
	.tx_done	()
);


top_dut DUT(
	.rxin_top		(txouttb),
	.clk_top			(clk_tb), 
	.rst_top			(rst_tb),
	.ena_top			(ena_tb),
	.sel_top			(sel_tb),

	.tickbd_top		(tickbd_tb),
	.ticksel_top	(ticksel_tb),
	.selbaud_top	(selbaud_tb), 
	.selmodtx_top	(selmodtx_tb), 
	.seltxff_top	(seltxff_tb), 
	.seltx_top		(seltx_tb),
	.refer_top		(refer_tb),
	.rxout_top		(rxout_tb),
	.rxdone_top		(rxdone_tb),
	.addrcw_top		(addrcw_tb),
	.dataoutcw_top	(dataoutcw_tb),
	.we_top			(we_tb),
	.q_top			(q_tb),	
	.flagff_top		(flagff_tb),
	.txdone_top		(txdone_tb),
	.addrcr_top		(addrcr_tb),
	.txenacr_top	(txenacr_tb),
	.txout_top		(txout_tb)
);

reg [7:0] i;

initial begin
	clk_tb = 1'b0;
	rst_tb = 1'b1;
	ena_tb = 1'b1;
	sel_tb = 2'd0;
	
	enatb = 1'b0;
	dataintb = 8'd0;
	#100;
	
	#10 rst_tb = 1'b0;
	#10 rst_tb = 1'b1;
	
	//cambiando bd range
	sel_tb = 2'd0;
	#500 ena_tb = 1'b0;
	#20 ena_tb = 1'b1;
	
	//cambiando bd range
	sel_tb = 2'd0;
	#500 ena_tb = 1'b0;
	#20 ena_tb = 1'b1;
	
	//---------------------------
	dataintb = 8'd99;
	#100 enatb = 1'b1;
	#100 enatb = 1'b0;
	#25000;
	
	for(i=1; i<=6; i=i+1) begin
		dataintb = i*35;
		#100 enatb = 1'b1;
		#100 enatb = 1'b0;
		#25000;
	end
	
	//regresar
	
	sel_tb = 2'd2;
	#10 ena_tb = 1'b0;
	#500 ena_tb = 1'b1;
	
	#250000 $stop;

end

always#1 clk_tb = ~clk_tb;

endmodule
