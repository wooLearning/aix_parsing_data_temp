`timescale 1ns/ 1ns

module parsing_test_tb();
	
reg clk, rstn, iStart;
//i_run;

/*for Test wire*/
reg [15:0] i_ena;		// enable for write address
reg [8:0] i_addra;	// input address for write
reg [15:0] i_wea;		// input write enable
reg [127:0] i_dia;		// input write data

wire [7:0] oDin0[0:15];
wire [7:0] oDin1[0:15];
wire [7:0] oDin2[0:15];
wire [7:0] oDin3[0:15];
wire [7:0] oDin4[0:15];
wire [7:0] oDin5[0:15];
wire [7:0] oDin6[0:15];
wire [7:0] oDin7[0:15];

wire oMac_vld;

parsing_top parsing_top_uut(
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
	.oDin0_0(oDin0[0]),
	.oDin0_1(oDin0[1]),
	.oDin0_2(oDin0[2]),
	.oDin0_3(oDin0[3]),
	.oDin0_4(oDin0[4]),
	.oDin0_5(oDin0[5]),
	.oDin0_6(oDin0[6]),
	.oDin0_7(oDin0[7]),
	.oDin0_8(oDin0[8]),
	.oDin0_9(oDin0[9]),
	.oDin0_10(oDin0[10]),
	.oDin0_11(oDin0[11]),
	.oDin0_12(oDin0[12]),
	.oDin0_13(oDin0[13]),
	.oDin0_14(oDin0[14]),
	.oDin0_15(oDin0[15]),

	.oDin1_0(oDin1[0]),
	.oDin1_1(oDin1[1]),
	.oDin1_2(oDin1[2]),
	.oDin1_3(oDin1[3]),
	.oDin1_4(oDin1[4]),
	.oDin1_5(oDin1[5]),
	.oDin1_6(oDin1[6]),
	.oDin1_7(oDin1[7]),
	.oDin1_8(oDin1[8]),
	.oDin1_9(oDin1[9]),
	.oDin1_10(oDin1[10]),
	.oDin1_11(oDin1[11]),
	.oDin1_12(oDin1[12]),
	.oDin1_13(oDin1[13]),
	.oDin1_14(oDin1[14]),
	.oDin1_15(oDin1[15]),

	.oDin2_0(oDin2[0]),
	.oDin2_1(oDin2[1]),
	.oDin2_2(oDin2[2]),
	.oDin2_3(oDin2[3]),
	.oDin2_4(oDin2[4]),
	.oDin2_5(oDin2[5]),
	.oDin2_6(oDin2[6]),
	.oDin2_7(oDin2[7]),
	.oDin2_8(oDin2[8]),
	.oDin2_9(oDin2[9]),
	.oDin2_10(oDin2[10]),
	.oDin2_11(oDin2[11]),
	.oDin2_12(oDin2[12]),
	.oDin2_13(oDin2[13]),
	.oDin2_14(oDin2[14]),
	.oDin2_15(oDin2[15]),

	.oDin3_0(oDin3[0]),
	.oDin3_1(oDin3[1]),
	.oDin3_2(oDin3[2]),
	.oDin3_3(oDin3[3]),
	.oDin3_4(oDin3[4]),
	.oDin3_5(oDin3[5]),
	.oDin3_6(oDin3[6]),
	.oDin3_7(oDin3[7]),
	.oDin3_8(oDin3[8]),
	.oDin3_9(oDin3[9]),
	.oDin3_10(oDin3[10]),
	.oDin3_11(oDin3[11]),
	.oDin3_12(oDin3[12]),
	.oDin3_13(oDin3[13]),
	.oDin3_14(oDin3[14]),
	.oDin3_15(oDin3[15]),

	.oDin4_0(oDin4[0]),
	.oDin4_1(oDin4[1]),
	.oDin4_2(oDin4[2]),
	.oDin4_3(oDin4[3]),
	.oDin4_4(oDin4[4]),
	.oDin4_5(oDin4[5]),
	.oDin4_6(oDin4[6]),
	.oDin4_7(oDin4[7]),
	.oDin4_8(oDin4[8]),
	.oDin4_9(oDin4[9]),
	.oDin4_10(oDin4[10]),
	.oDin4_11(oDin4[11]),
	.oDin4_12(oDin4[12]),
	.oDin4_13(oDin4[13]),
	.oDin4_14(oDin4[14]),
	.oDin4_15(oDin4[15]),

	.oDin5_0(oDin5[0]),
	.oDin5_1(oDin5[1]),
	.oDin5_2(oDin5[2]),
	.oDin5_3(oDin5[3]),
	.oDin5_4(oDin5[4]),
	.oDin5_5(oDin5[5]),
	.oDin5_6(oDin5[6]),
	.oDin5_7(oDin5[7]),
	.oDin5_8(oDin5[8]),
	.oDin5_9(oDin5[9]),
	.oDin5_10(oDin5[10]),
	.oDin5_11(oDin5[11]),
	.oDin5_12(oDin5[12]),
	.oDin5_13(oDin5[13]),
	.oDin5_14(oDin5[14]),
	.oDin5_15(oDin5[15]),

	.oDin6_0(oDin6[0]),
	.oDin6_1(oDin6[1]),
	.oDin6_2(oDin6[2]),
	.oDin6_3(oDin6[3]),
	.oDin6_4(oDin6[4]),
	.oDin6_5(oDin6[5]),
	.oDin6_6(oDin6[6]),
	.oDin6_7(oDin6[7]),
	.oDin6_8(oDin6[8]),
	.oDin6_9(oDin6[9]),
	.oDin6_10(oDin6[10]),
	.oDin6_11(oDin6[11]),
	.oDin6_12(oDin6[12]),
	.oDin6_13(oDin6[13]),
	.oDin6_14(oDin6[14]),
	.oDin6_15(oDin6[15]),

	.oDin7_0(oDin7[0]),
	.oDin7_1(oDin7[1]),
	.oDin7_2(oDin7[2]),
	.oDin7_3(oDin7[3]),
	.oDin7_4(oDin7[4]),
	.oDin7_5(oDin7[5]),
	.oDin7_6(oDin7[6]),
	.oDin7_7(oDin7[7]),
	.oDin7_8(oDin7[8]),
	.oDin7_9(oDin7[9]),
	.oDin7_10(oDin7[10]),
	.oDin7_11(oDin7[11]),
	.oDin7_12(oDin7[12]),
	.oDin7_13(oDin7[13]),
	.oDin7_14(oDin7[14]),
	.oDin7_15(oDin7[15]),
	
	.oMac_vld(oMac_vld)
);

// Clock
parameter CLK_PERIOD = 10;	//100MHz
initial begin
	clk = 1'b1;
	forever #(CLK_PERIOD/2) clk = ~clk;
end

integer i=0;

initial begin
	rstn = 1'b0;
	#10;
	rstn = 1'b1;
	
	iStart = 1'b0;
	//i_run = 1'b0;


	/*bram init*/
	
	i_ena = 16'b0000_0000_0000_0001;
	i_wea = 16'b0000_0000_0000_0001;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hF0E0_D0C0_B0A0_9080_7060_5040_3020_1000;
	end
	@(posedge clk);

	i_ena = 16'b0000_0000_0000_0010;
	i_wea = 16'b0000_0000_0000_0010;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hF1E1_D1C1_B1A1_9181_7161_5141_3121_1101;
	end
	@(posedge clk);

	i_ena = 16'b0000_0000_0000_0100;
	i_wea = 16'b0000_0000_0000_0100;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hF2E2_D2C2_B2A2_9282_7262_5242_3222_1202;
	end
	
	@(posedge clk);
	i_ena = 16'b0000_0000_0000_1000;
	i_wea = 16'b0000_0000_0000_1000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hF3E3_D3C3_B3A3_9383_7363_5343_3323_1303;
	end
	@(posedge clk);
	i_ena = 16'b0000_0000_0001_0000;
	i_wea = 16'b0000_0000_0001_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hF4E4_D4C4_B4A4_9484_7464_5444_3424_1404;
	end
	@(posedge clk);
	i_ena = 16'b0000_0000_0010_0000;
	i_wea = 16'b0000_0000_0010_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hF5E5_D5C5_B5A5_9585_7565_5545_3525_1505;
	end
	@(posedge clk);
	i_ena = 16'b0000_0000_0100_0000;
	i_wea = 16'b0000_0000_0100_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hF6E6_D6C6_B6A6_9686_7666_5646_3626_1606;
	end
	@(posedge clk);
	i_ena = 16'b0000_0000_1000_0000;
	i_wea = 16'b0000_0000_1000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hF7E7_D7C7_B7A7_9787_7767_5747_3727_1707;
	end
	@(posedge clk);
	i_ena = 16'b0000_0001_0000_0000;
	i_wea = 16'b0000_0001_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hF8E8_D8C8_B8A8_9888_7868_5848_3828_1808;
	end
	@(posedge clk);
	i_ena = 16'b0000_0010_0000_0000;
	i_wea = 16'b0000_0010_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hF9E9_D9C9_B9A9_9989_7969_5949_3929_1909;
	end
	@(posedge clk);
	i_ena = 16'b0000_0100_0000_0000;
	i_wea = 16'b0000_0100_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hFAEA_DACA_BAAA_9A8A_7A6A_5A4A_3A2A_1A0A;
	end
	@(posedge clk);
	i_ena = 16'b0000_1000_0000_0000;
	i_wea = 16'b0000_1000_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hFBEB_DBDB_BBBB_9B8B_7B6B_5B4B_3B2B_1B0B;
	end
	@(posedge clk);
	i_ena = 16'b0001_0000_0000_0000;
	i_wea = 16'b0001_0000_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hFCEC_DCCC_BCBC_9C8C_7C6C_5C4C_3C2C_1C0C;
	end
	@(posedge clk);
	i_ena = 16'b0010_0000_0000_0000;
	i_wea = 16'b0010_0000_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hFDED_DDCD_BDBD_9D8D_7D6D_5D4D_3D2D_1D0D;
	end
	@(posedge clk);
	i_ena = 16'b0100_0000_0000_0000;
	i_wea = 16'b0100_0000_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hFEED_DECE_BEAE_9E8E_7E6E_5E4E_3E2E_1E0E;
	end
	@(posedge clk);
	i_ena = 16'b1000_0000_0000_0000;
	i_wea = 16'b1000_0000_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 128'hFFEF_DFCF_BFAF_9F8F_7F6F_5F4F_3F2F_1F0F;
	end
	@(posedge clk);

	#(CLK_PERIOD*10);
	i_ena = 16'h0;
	i_wea = 16'h0;
	@(posedge clk);
	
	iStart = 1'b1;
	//i_run = 1'b1;
	
end

endmodule