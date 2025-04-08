module parsing_top (
	input clk,
	input rstn,
	input iStart,
	//input i_run,

	/*for Test wire*/
	input [15:0] i_ena,		// enable for write address
	input [8:0] i_addra,	// input address for write
	input [15:0] i_wea,		// input write enable
	input [127:0] i_dia,		// input write data

	/* AFTER ZERO PADDING */
	output [7:0] oDin0,
	output [7:0] oDin1,
	output [7:0] oDin2,
	output [7:0] oDin3,
	output [7:0] oDin4,
	output [7:0] oDin5,
	output [7:0] oDin6,
	output [7:0] oDin7,
	output [7:0] oDin8,
	output [7:0] oDin9,
	output [7:0] oDin10,
	output [7:0] oDin11,
	output [7:0] oDin12,
	output [7:0] oDin13,
	output [7:0] oDin14,
	output [7:0] oDin15
);
	
wire [15:0] w_oCs;
wire [8:0] w_oAddr[0:15];
wire [127:0] w_iData[0:15];

wire [7:0] w_oDin[0:15];

parsing_data_layer00 parsing_dut(
    .clk(clk),
    .rstn(rstn),
	.iStart(iStart),
	//.i_run(i_run),

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

	.oDin0(w_oDin[0]),
	.oDin1(w_oDin[1]),
	.oDin2(w_oDin[2]),
	.oDin3(w_oDin[3]),
	.oDin4(w_oDin[4]),
	.oDin5(w_oDin[5]),
	.oDin6(w_oDin[6]),
	.oDin7(w_oDin[7]),
	.oDin8(w_oDin[8]),
	.oDin9(w_oDin[9]),
	.oDin10(w_oDin[10]),
	.oDin11(w_oDin[11]),
	.oDin12(w_oDin[12]),
	.oDin13(w_oDin[13]),
	.oDin14(w_oDin[14]),
	.oDin15(w_oDin[15])

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

assign oDin0 = w_oDin[0];
assign oDin1 = w_oDin[1];
assign oDin2 = w_oDin[2];
assign oDin3 = w_oDin[3];
assign oDin4 = w_oDin[4];
assign oDin5 = w_oDin[5];
assign oDin6 = w_oDin[6];
assign oDin7 = w_oDin[7];
assign oDin8 = w_oDin[8];
assign oDin9 = w_oDin[9];
assign oDin10 = w_oDin[10];
assign oDin11 = w_oDin[11];
assign oDin12 = w_oDin[12];
assign oDin13 = w_oDin[13];
assign oDin14 = w_oDin[14];
assign oDin15 = w_oDin[15];


endmodule