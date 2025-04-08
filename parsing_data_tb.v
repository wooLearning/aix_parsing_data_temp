module parsing_data_tb ();

reg clk;
reg rstn;
reg iStart;
reg i_run;

wire [15:0] oCs; // chip enable

wire [8:0] oAddr0;
wire [8:0] oAddr1;
wire [8:0] oAddr2;
wire [8:0] oAddr3;
wire [8:0] oAddr4;
wire [8:0] oAddr5;
wire [8:0] oAddr6;
wire [8:0] oAddr7;
wire [8:0] oAddr8;
wire [8:0] oAddr9;
wire [8:0] oAddr10;
wire [8:0] oAddr11;
wire [8:0] oAddr12;
wire [8:0] oAddr13;
wire [8:0] oAddr14;
wire [8:0] oAddr15;

reg [127:0] iData[0:15]; //from bram data

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

// Clock
parameter CLK_PERIOD = 10;	//100MHz
initial begin
	clk = 1'b1;
	forever #(CLK_PERIOD/2) clk = ~clk;
end

integer i=0;


parsing_data_layer00 uut(
    .clk(clk),
    .rstn(rstn),
	.iStart(iStart),
	.i_run(i_run),

	.oCs(oCs), // chip enable

	.oAddr0(oAddr0),
	.oAddr1(oAddr1),
	.oAddr2(oAddr2),
	.oAddr3(oAddr3),
	.oAddr4(oAddr4),
	.oAddr5(oAddr5),
	.oAddr6(oAddr6),
	.oAddr7(oAddr7),
	.oAddr8(oAddr8),
	.oAddr9(oAddr9),
	.oAddr10(oAddr10),
	.oAddr11(oAddr11),
	.oAddr12(oAddr12),
	.oAddr13(oAddr13),
	.oAddr14(oAddr14),
	.oAddr15(oAddr15),

	.iData0(iData[0]), //from bram data
	.iData1(iData[1]),
	.iData2(iData[2]),
	.iData3(iData[3]),
	.iData4(iData[4]),
	.iData5(iData[5]),
	.iData6(iData[6]),
	.iData7(iData[7]),
	.iData8(iData[8]),
	.iData9(iData[9]),
	.iData10(iData[10]),
	.iData11(iData[11]),
	.iData12(iData[12]),
	.iData13(iData[13]),
	.iData14(iData[14]),
	.iData15(iData[15]),

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
	.oDin15(oDin15)

);


initial begin
	rstn = 1'b1;
	#(CLK_PERIOD*20);
	rstn = 1'b0;

	for(i=0;i<16;i=i+1) begin
		iData[i] = i;
	end

	#100;
	@(posedge clk);
	
end

endmodule