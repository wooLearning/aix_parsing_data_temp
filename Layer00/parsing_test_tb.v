`timescale 1ns/ 1ns

module parsing_test_tb();
	
reg clk, rstn, iStart;
//i_run;

/*for Test wire*/
reg [15:0] i_ena;		// enable for write address
reg [8:0] i_addra;	// input address for write
reg [15:0] i_wea;		// input write enable
reg [127:0] i_dia;		// input write data

reg [72:0] iWeight[0:11];
reg [15:0] iBias[0:3];

wire [7:0] oLayer[0:3];

layer00 layer00(
	.clk(clk),
	.rstn(rstn),
	.iStart(iStart),

	/*for Test wire*/
	.i_ena(i_ena),		// enable for write address
	.i_addra(i_addra),	// input address for write
	.i_wea(i_wea),		// input write enable
	.i_dia(i_dia),		// input write data

	.iBias0(iBias[0]),
	.iBias1(iBias[1]),
	.iBias2(iBias[2]),
	.iBias3(iBias[3]),

	.oLayer0_0(oLayer[0]),
	.oLayer0_1(oLayer[1]),
    .oLayer0_2(oLayer[2]),
    .oLayer0_3(oLayer[3])
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
	for(i=0; i<12; i=i+1) begin
		iWeight[i] = 72'h08_0706_0504_0302_0100;
	end
	for (i=0; i<4; i=i+1 ) begin
		iBias[i] = 16'h9;
	end
	
end

endmodule