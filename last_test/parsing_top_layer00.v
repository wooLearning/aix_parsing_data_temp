module parsing_top_layer00 (
	input clk,
	input rstn,
	input iStart,

	/*for Test wire*/
	input [15:0] i_ena,		// enable for write address
	input [8:0] i_addra,	// input address for write
	input [15:0] i_wea,		// input write enable
	input [127:0] i_dia,		// input write data

	/* AFTER ZERO PADDING */
	output [127:0] oDin0,
	output [127:0] oDin1,
	output [127:0] oDin2,
	output [127:0] oDin3,

	output oMac_vld// mac에 이 신호 전달에서 mul 시작
);
	
wire [15:0] w_oCs;
wire [8:0] w_oAddr[0:15];
wire [127:0] w_iData[0:15];

//wire [7:0] w_oDin[0:15];

parsing_data_layer00 parsing_dut(
    .clk(clk),
    .rstn(rstn),
	.iStart(iStart),

	.oCs(w_oCs), // chip enable

	.oAddr0(w_oAddr[0]),
	.oAddr1(w_oAddr[1]),
	.oAddr2(w_oAddr[2]),
	.oAddr3(w_oAddr[3]),
	.oAddr4(w_oAddr[4]),
	.oAddr5(w_oAddr[5]),
	.oAddr6(w_oAddr[6]),
	.oAddr7(w_oAddr[7]),
	.oAddr8(w_oAddr[8]),
	.oAddr9(w_oAddr[9]),
	.oAddr10(w_oAddr[10]),
	.oAddr11(w_oAddr[11]),
	.oAddr12(w_oAddr[12]),
	.oAddr13(w_oAddr[13]),
	.oAddr14(w_oAddr[14]),
	.oAddr15(w_oAddr[15]),

	.iData0(w_iData[0]), //from bram data
	.iData1(w_iData[1]),
	.iData2(w_iData[2]),
	.iData3(w_iData[3]),
	.iData4(w_iData[4]),
	.iData5(w_iData[5]),
	.iData6(w_iData[6]),
	.iData7(w_iData[7]),
	.iData8(w_iData[8]),
	.iData9(w_iData[9]),
	.iData10(w_iData[10]),
	.iData11(w_iData[11]),
	.iData12(w_iData[12]),
	.iData13(w_iData[13]),
	.iData14(w_iData[14]),
	.iData15(w_iData[15]),

	.oDin0_0(oDin0[0+:8]),
	.oDin0_1(oDin0[8+:8]),
	.oDin0_2(oDin0[16+:8]),
	.oDin0_3(oDin0[24+:8]),
	.oDin0_4(oDin0[32+:8]),
	.oDin0_5(oDin0[40+:8]),
	.oDin0_6(oDin0[48+:8]),
	.oDin0_7(oDin0[56+:8]),
	.oDin0_8(oDin0[64+:8]),
	.oDin0_9(oDin0[72+:8]),
	.oDin0_10(oDin0[80+:8]),
	.oDin0_11(oDin0[88+:8]),
	.oDin0_12(oDin0[96+:8]),
	.oDin0_13(oDin0[104+:8]),
	.oDin0_14(oDin0[112+:8]),
	.oDin0_15(oDin0[120+:8]),

	.oDin1_0(oDin1[0+:8]),
	.oDin1_1(oDin1[8+:8]),
	.oDin1_2(oDin1[16+:8]),
	.oDin1_3(oDin1[24+:8]),
	.oDin1_4(oDin1[32+:8]),
	.oDin1_5(oDin1[40+:8]),
	.oDin1_6(oDin1[48+:8]),
	.oDin1_7(oDin1[56+:8]),
	.oDin1_8(oDin1[64+:8]),
	.oDin1_9(oDin1[72+:8]),
	.oDin1_10(oDin1[80+:8]),
	.oDin1_11(oDin1[88+:8]),
	.oDin1_12(oDin1[96+:8]),
	.oDin1_13(oDin1[104+:8]),
	.oDin1_14(oDin1[112+:8]),
	.oDin1_15(oDin1[120+:8]),

	.oDin2_0(oDin2[0+:8]),
	.oDin2_1(oDin2[8+:8]),
	.oDin2_2(oDin2[16+:8]),
	.oDin2_3(oDin2[24+:8]),
	.oDin2_4(oDin2[32+:8]),
	.oDin2_5(oDin2[40+:8]),
	.oDin2_6(oDin2[48+:8]),
	.oDin2_7(oDin2[56+:8]),
	.oDin2_8(oDin2[64+:8]),
	.oDin2_9(oDin2[72+:8]),
	.oDin2_10(oDin2[80+:8]),
	.oDin2_11(oDin2[88+:8]),
	.oDin2_12(oDin2[96+:8]),
	.oDin2_13(oDin2[104+:8]),
	.oDin2_14(oDin2[112+:8]),
	.oDin2_15(oDin2[120+:8]),

	.oMac_vld(oMac_vld)
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_0(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[0]),		// enable for read address
	.addrb(w_oAddr[0]),		// input address for read
	.dob(w_iData[0]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[0]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[0]),		// input write enable
	.dia(i_dia) 	// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_1(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[1]),		// enable for read address
	.addrb(w_oAddr[1]),		// input address for read
	.dob(w_iData[1]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[1]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[1]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_2(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[2]),		// enable for read address
	.addrb(w_oAddr[2]),		// input address for read
	.dob(w_iData[2]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[2]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[2]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_3(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[3]),		// enable for read address
	.addrb(w_oAddr[3]),		// input address for read
	.dob(w_iData[3]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[3]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[3]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_4(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[4]),		// enable for read address
	.addrb(w_oAddr[4]),		// input address for read
	.dob(w_iData[4]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[4]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[4]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_5(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[5]),		// enable for read address
	.addrb(w_oAddr[5]),		// input address for read
	.dob(w_iData[5]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[5]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[5]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_6(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[6]),		// enable for read address
	.addrb(w_oAddr[6]),		// input address for read
	.dob(w_iData[6]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[6]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[6]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_7(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[7]),		// enable for read address
	.addrb(w_oAddr[7]),		// input address for read
	.dob(w_iData[7]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[7]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[7]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_8(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[8]),		// enable for read address
	.addrb(w_oAddr[8]),		// input address for read
	.dob(w_iData[8]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[8]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[8]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_9(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[9]),		// enable for read address
	.addrb(w_oAddr[9]),		// input address for read
	.dob(w_iData[9]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[9]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[9]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_10(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[10]),		// enable for read address
	.addrb(w_oAddr[10]),		// input address for read
	.dob(w_iData[10]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[10]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[10]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_11(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[11]),		// enable for read address
	.addrb(w_oAddr[11]),		// input address for read
	.dob(w_iData[11]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[11]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[11]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_12(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[12]),		// enable for read address
	.addrb(w_oAddr[12]),		// input address for read
	.dob(w_iData[12]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[12]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[12]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_13(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[13]),		// enable for read address
	.addrb(w_oAddr[13]),		// input address for read
	.dob(w_iData[13]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[13]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[13]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_14(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[14]),		// enable for read address
	.addrb(w_oAddr[14]),		// input address for read
	.dob(w_iData[14]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[14]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[14]),		// input write enable
	.dia(i_dia)		// input write data
);

dpram_wrapper #(.DW(128), .AW(9), .DEPTH(512))
dpram_512x128_15(	
	.clk(clk),		// clock 

	//READ SIGNAL
	.enb(w_oCs[15]),		// enable for read address
	.addrb(w_oAddr[15]),		// input address for read
	.dob(w_iData[15]),			// output read-out data

	//WRITE SIGNAL
	.ena(i_ena[15]),		// enable for write address
	.addra(i_addra),		// input address for write
	.wea(i_wea[15]),		// input write enable
	.dia(i_dia)		// input write data
);



endmodule