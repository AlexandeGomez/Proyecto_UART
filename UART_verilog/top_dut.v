module top_dut(
input rxin_top,
input clk_top, 
input rst_top,
input ena_top,
input [1:0] sel_top,
input [7:0] datainsw_top, //entrada de los switches

output tickbd_top,
output ticksel_top,
output selbaud_top, selmodtx_top, seltxff_top, seltx_top,
output [8:0] refer_top,
output [7:0] rxout_top,
output rxdone_top,
output [2:0] addrcw_top,
output [7:0] dataoutcw_top,
output we_top,
output [7:0] q_top,
output flagff_top,
output flagtx_top,

output txdone_top,
output [2:0] addrcr_top,
output txenacr_top,
output txout_top,
output [7:0] dataintx_top, //entrada al tx multiplexada
output cntmodtx_top,
output [7:0] HEXBD0_top, HEXBD1_top, HEXBD2_top,HEXBD3_top,HEXBD4_top,HEXBD5_top,
output [7:0] HEXTM0_top, HEXTM1_top, HEXTM2_top,HEXTM3_top,HEXTM4_top,HEXTM5_top,
output [7:0] HEXRX0_top, HEXRX1_top, HEXRX2_top,HEXRX3_top,HEXRX4_top,HEXRX5_top, 
output [7:0] HEX0_top, HEX1_top, HEX2_top, HEX3_top, HEX4_top, HEX5_top, 
output [7:0] outcodascii
);

//--------------------- MUX PARA INTERACCIONES
 muxtwoselfour MUXSELFOUR(
	.ena		(ena_top),
	.sel		(sel_top),

	.selbaud	(selbaud_top), 
	.selmodtx(selmodtx_top),
	.seltxff	(seltxff_top), 
	.seltx	(seltx_top)
);

//---------------------MODULO SELECTOR DE BAUDAGE
baudselect BAUDSEL(
	.selbaud	(selbaud_top), 
	.ticksel	(ticksel_top), 
	.rst		(rst_top),

	.refer	(refer_top)
);

//-------------------- GENERADOR DE BAUDAGE
baudgenerator BAUDGEN(
	.clk		(clk_top), 
	.rst		(rst_top),
	.refer	(refer_top),

	.tickbd	(tickbd_top)
);

//------------------- PRESCALER
prescaler #(	.COUNTER_SIZE(24)) PRESSEL(
	.fast_clock	(clk_top), 
	.rst			(rst_top),

	.slow_clock	(ticksel_top)
);


//------------------ RX
rx #(	.NBITS(8), 	.NTICKB(16)) RX(
	.bdtick	(tickbd_top), 
	.rx_in	(rxin_top), 
	.rx_rst	(rst_top),
	
	.rx_done	(rxdone_top),
	.rx_out	(rxout_top) 
);

//----------------- CONTROL ESCRITURA
controlwrite CW(
	.clk		(tickbd_top), 
	.rst		(rst_top),
	.datain	(rxout_top),
	.rxdone	(rxdone_top),

	.addr		(addrcw_top),
	.dataout	(dataoutcw_top),
	.we		(we_top)
);

//-----------------Codoficador para las entradas
codASCII7SEG CODASCII(
	.datain	(dataoutcw_top),
	.datadone	(we_top),

	.dataout	(outcodascii)
);



//-----------------RAM
SDP_DCRAM #(	.DATA_WIDTH(8),	.ADDR_WIDTH(3)) RAM(
	.data			(dataoutcw_top),
	.read_addr	(addrcr_top), 
	.write_addr	(addrcw_top),
	.we			(we_top), 
	.read_clock	(clk_top), 
	.write_clock(clk_top),
	.q				(q_top)
);

//---------------- ONEPULSE
onepulse OPFIFO(
	.tickbd		(tickbd_top), 
	.ticksel		(ticksel_top), 
	.ena			(seltxff_top),

	.flag			(flagff_top)
);


//-------------- CONTROL LECUTRA
controlread CR(
	.tickbd		(tickbd_top), 
	.rst			(rst_top), 
	.ticksend	(flagff_top),
	.txdone		(txdone_top),

	.addr			(addrcr_top),
	.txena		(txenacr_top)
);

//---------------- MODO DE TRANSMISION
modetxselect MODTX(
	.selmodtx	(selmodtx_top), 
	.ticksel		(ticksel_top), 
	.rst			(rst_top),
	.datainsw	(datainsw_top),
	.datainff	(q_top),

	.dataintx	(dataintx_top),
	.cnt			(cntmodtx_top)
);

// One pulse de entrada al tx
onepulse OPTXENA(
	.tickbd	(tickbd_top), 
	.ticksel	(ticksel_top), 
	.ena		(seltx_top),

	.flag		(flagtx_top)
);


//---------------- TX
tx #(	.NBITS(8),	.NTICK(16)) TX(
	.bdtick		(tickbd_top), 
	.tx_ena		(flagtx_top), 
	.tx_rst		(rst_top), 
	.txff_ena	(txenacr_top),
	.data_in		(dataintx_top),

   .tx_out		(txout_top), 
	.tx_done		(txdone_top)
);

//----------------------- Salida a los segmentos
referto7seg REF7SEG(
	.refer	(refer_top),

	.HEX0		(HEXBD0_top), 
	.HEX1		(HEXBD1_top), 
	.HEX2		(HEXBD2_top), 
	.HEX3		(HEXBD3_top), 
	.HEX4		(HEXBD4_top), 
	.HEX5		(HEXBD5_top)
);

txmodeto7seg MODETXTO7(
	.cntmodetx	(cntmodtx_top),

	.HEX0			(HEXTM0_top), 
	.HEX1			(HEXTM1_top), 
	.HEX2			(HEXTM2_top), 
	.HEX3			(HEXTM3_top), 
	.HEX4			(HEXTM4_top), 
	.HEX5			(HEXTM5_top)
);

//---------------- CONEXION 7 SEGMENTOS ENTRADAS RX
muxrxout MUXOUT(
	.HEXIN	(outcodascii),
	.addrwin	(addrcw_top),
	.ena		(we_top),

	.HEX0		(HEXRX0_top), 
	.HEX1		(HEXRX1_top), 
	.HEX2		(HEXRX2_top), 
	.HEX3		(HEXRX3_top), 
	.HEX4		(HEXRX4_top), 
	.HEX5		(HEXRX5_top)
);

//MUX a los 7 segmentos
mux7segtxmode MUX7SEGALL(
	 .HEXBD0		(HEXBD0_top),
	 .HEXBD1		(HEXBD1_top),
	 .HEXBD2		(HEXBD2_top),
	 .HEXBD3		(HEXBD3_top),
	 .HEXBD4		(HEXBD4_top), 
	 .HEXBD5		(HEXBD5_top),
	
	 .HEXTM0		(HEXTM0_top),
	 .HEXTM1		(HEXTM1_top),	
	 .HEXTM2		(HEXTM2_top),
	 .HEXTM3		(HEXTM3_top),
	 .HEXTM4		(HEXTM4_top),
	 .HEXTM5		(HEXTM5_top),

	 .HEXCD0		(HEXRX0_top),
	 .HEXCD1		(HEXRX1_top),	
	 .HEXCD2		(HEXRX2_top),
	 .HEXCD3		(HEXRX3_top),
	 .HEXCD4		(HEXRX4_top),
	 .HEXCD5		(HEXRX5_top),

	 .sel			(sel_top),

	 
   .HEX0			(HEX0_top),
   .HEX1			(HEX1_top),
   .HEX2			(HEX2_top),
   .HEX3			(HEX3_top),
   .HEX4			(HEX4_top),
   .HEX5			(HEX5_top)
);

endmodule
