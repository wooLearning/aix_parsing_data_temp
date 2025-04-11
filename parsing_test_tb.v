`timescale 1ns/ 1ns

module parsing_test_tb  ();
	
reg clk, rstn, iStart;
//i_run;

/*for Test wire*/
reg [15:0] i_ena;		// enable for write address
reg [8:0] i_addra;	// input address for write
reg [15:0] i_wea;		// input write enable
reg [127:0] i_dia;		// input write data

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
		i_dia = 127'h0000_0000;
	end
	@(posedge clk);

	i_ena = 16'b0000_0000_0000_0010;
	i_wea = 16'b0000_0000_0000_0010;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h4131_2111;
	end
	@(posedge clk);

	i_ena = 16'b0000_0000_0000_0100;
	i_wea = 16'b0000_0000_0000_0100;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h42322212;
	end
	
	@(posedge clk);
	i_ena = 16'b0000_0000_0000_1000;
	i_wea = 16'b0000_0000_0000_1000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h43332313;
	end
	@(posedge clk);
	i_ena = 16'b0000_0000_0001_0000;
	i_wea = 16'b0000_0000_0001_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h44342414;
	end
	@(posedge clk);
	i_ena = 16'b0000_0000_0010_0000;
	i_wea = 16'b0000_0000_0010_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h45352515;
	end
	@(posedge clk);
	i_ena = 16'b0000_0000_0100_0000;
	i_wea = 16'b0000_0000_0100_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h46362616;
	end
	@(posedge clk);
	i_ena = 16'b0000_0000_1000_0000;
	i_wea = 16'b0000_0000_1000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h47372717;
	end
	@(posedge clk);
	i_ena = 16'b0000_0001_0000_0000;
	i_wea = 16'b0000_0001_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h48382818;
	end
	@(posedge clk);
	i_ena = 16'b0000_0010_0000_0000;
	i_wea = 16'b0000_0010_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h49392919;
	end
	@(posedge clk);
	i_ena = 16'b0000_0100_0000_0000;
	i_wea = 16'b0000_0100_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h4A3A2A1A;
	end
	@(posedge clk);
	i_ena = 16'b0000_1000_0000_0000;
	i_wea = 16'b0000_1000_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h4B3B2B1B;
	end
	@(posedge clk);
	i_ena = 16'b0001_0000_0000_0000;
	i_wea = 16'b0001_0000_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h4C3C2C1C;
	end
	@(posedge clk);
	i_ena = 16'b0010_0000_0000_0000;
	i_wea = 16'b0010_0000_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h4D3D2D1D;
	end
	@(posedge clk);
	i_ena = 16'b0100_0000_0000_0000;
	i_wea = 16'b0100_0000_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h4E3E2E1E;
	end
	@(posedge clk);
	i_ena = 16'b1000_0000_0000_0000;
	i_wea = 16'b1000_0000_0000_0000;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = 127'h4F3F2F1F;
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