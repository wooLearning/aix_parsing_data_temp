module layer00_top_tb ();
	
reg clk, rstn, iStart;

reg [15:0] i_ena;		// enable for write address
reg [8:0] i_addra;	// input address for write
reg [15:0] i_wea;		// input write enable
reg [127:0] i_dia;		// input write data

reg [7:0] iWeight[0:8];

reg [15:0] iBias;

reg [7:0] oOut;

layer00_top layer00_top (
	.clk(clk),
	.rstn(rstn),
	.iStart(iStart),

	/*for Test wire*/
	.i_ena(i_ena),		// enable for write address
	.i_addra(i_addra),	// input address for write
	.i_wea(i_wea),		// input write enable
	.i_dia(i_dia),		// input write data

	.iWeight0(iWeight[0]),
	.iWeight1(iWeight[1]),
	.iWeight2(iWeight[2]),
	.iWeight3(iWeight[3]),
	.iWeight4(iWeight[4]),
	.iWeight5(iWeight[5]),
	.iWeight6(iWeight[6]),
	.iWeight7(iWeight[7]),
    .iWeight8(iWeight[8]),

	.iBias(iBias),

	.oOut(oOut)
);


endmodule