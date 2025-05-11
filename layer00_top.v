module layer00_top (
	input clk,
	input rstn,
	input iStart,
	//input i_run,

	/*for Test wire*/
	input [15:0] i_ena,		// enable for write address
	input [8:0] i_addra,	// input address for write
	input [15:0] i_wea,		// input write enable
	input [127:0] i_dia,		// input write data

	input [7:0] iWeight0,
	input [7:0] iWeight1,
	input [7:0] iWeight2,
	input [7:0] iWeight3,
	input [7:0] iWeight4,
	input [7:0] iWeight5,
	input [7:0] iWeight6,
	input [7:0] iWeight7,
    input [7:0] iWeight8,

	input [15:0] iBias,

	output [7:0] oOut
);
	

/* AFTER ZERO PADDING */
wire [7:0] oDin0;
wire [7:0] oDin1;
wire [7:0] oDin2;
wire [7:0] oDin3;
wire [7:0] oDin4;
wire [7:0] oDin5;
wire [7:0] oDin6;
wire [7:0] oDin7;
wire [7:0] oDin8;
wire [7:0] oDin9;
wire [7:0] oDin10;
wire [7:0] oDin11;
wire [7:0] oDin12;
wire [7:0] oDin13;
wire [7:0] oDin14;
wire [7:0] oDin15;

wire oMac_vld// mac에 이 신호 전달에서 mul 시작

parsing_top parsing_top_layer00 (
	.clk(clk),
	.rstn(rstn),
	.iStart(iStart),
	//.i_run(i_run),

	/*for Test wire*/
	.i_ena(i_ena),	// enable for write address
	.i_addra(i_addra),	// input address for write
	.i_wea(i_wea),	// input write enable
	.i_dia(i_dia),	// input write data

	/* AFTER ZERO PADDING */
	.oDin0(oDin0),
	.oDin1(oDin1),
	.oDin2(oDin2),
	.oDin3(oDin3),
	.oDin4(oDin4),
	.oDin5(oDin5),
	.oDin6(oDin6),
	.oDin7(oDin7),
	.oDin8(oDin8),
	.oDin9(oDin9),
	.oDin10(oDin10),
	.oDin11(oDin11),
	.oDin12(oDin12),
	.oDin13(oDin13),
	.oDin14(oDin14),
	.oDin15(oDin15),

	.oMac_vld(oMac_vld)// mac에 이 신호 전달에서 mul 시작
);

mac mac(
    .clk(clk), 
    .rstn(rstn), 
    .vld_i(oMac_vld), 

    .iDin0(oDin0),
	.iDin1(oDin1),
	.iDin2(oDin2),
	.iDin3(oDin3),
	.iDin4(oDin4),
	.iDin5(oDin5),
	.iDin6(oDin6),
	.iDin7(oDin7),
	.iDin8(oDin8),
	.iDin9(oDin9),
	.iDin10(oDin10),
	.iDin11(oDin11),
	.iDin12(oDin12),
	.iDin13(oDin13),
	.iDin14(oDin14),
	.iDin15(oDin15),

	.iWeight0(iWeight0),
	.iWeight1(iWeight1),
	.iWeight2(iWeight2),
	.iWeight3(iWeight3),
	.iWeight4(iWeight4),
	.iWeight5(iWeight5),
	.iWeight6(iWeight6),
	.iWeight7(iWeight7),
	.iWeight8(iWeight8),

	.iBias(iBias),

    .oOut(oOut)
);

endmodule