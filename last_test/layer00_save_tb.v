module layer00_save_tb ();
	
reg clk, rstn, i_vld;
reg [31:0] i_ofm;

wire [127:0] i_ifm;

wire [9:0] o_addr0;
wire [9:0] o_addr1;
wire [9:0] o_addr2;
wire [9:0] o_addr3;
wire [9:0] o_addr4;
wire [9:0] o_addr5;
wire [9:0] o_addr6;
wire [9:0] o_addr7;
wire [9:0] o_addr8;
wire [9:0] o_addr9;
wire [9:0] o_addr10;
wire [9:0] o_addr11;
wire [9:0] o_addr12;
wire [9:0] o_addr13;
wire [9:0] o_addr14;
wire [9:0] o_addr15;

layer00_save layer00_save(
	.clk(clk),
	.rstn(rstn),
	.i_vld(i_vld),

	.i_ofm(i_ofm),
	.i_ifm(i_ifm),

	.o_addr0(o_addr0),
	.o_addr1(o_addr1),
	.o_addr2(o_addr2),
	.o_addr3(o_addr3),
	.o_addr4(o_addr4),
	.o_addr5(o_addr5),
	.o_addr6(o_addr6),
	.o_addr7(o_addr7),
	.o_addr8(o_addr8),
	.o_addr9(o_addr9),
	.o_addr10(o_addr10),
	.o_addr11(o_addr11),
	.o_addr12(o_addr12),
	.o_addr13(o_addr13),
	.o_addr14(o_addr14),
	.o_addr15(o_addr15)
);


// Clock
parameter CLK_PERIOD = 10;	//100MHz
initial begin
	clk = 1'b1;
	forever #(CLK_PERIOD/2) clk = ~clk;
end
initial begin
	i_vld = 1'b0;
	#(CLK_PERIOD*2);
	forever #(CLK_PERIOD*4) i_vld = ~i_vld;
end

initial begin
	rstn = 1'b0;

	i_ofm = 32'd0;
	#(CLK_PERIOD*2);
	rstn = 1'b1;
	#(CLK_PERIOD*2);

	i_ofm = 32'h11111111;
	#(CLK_PERIOD*2);
	i_ofm = 32'h22222222;
	#(CLK_PERIOD*2);
	i_ofm = 32'h33333333;
	#(CLK_PERIOD*2);
	i_ofm = 32'h44444444;
	#(CLK_PERIOD*2);
	i_ofm = 32'h55555555;
	#(CLK_PERIOD*2);
	i_ofm = 32'h66666666;
	#(CLK_PERIOD*2);
	i_ofm = 32'h77777777;
	#(CLK_PERIOD*2);
	i_ofm = 32'h88888888;
	#(CLK_PERIOD*2);
	i_ofm = 32'h99999999;
	#(CLK_PERIOD*2);
	i_ofm = 32'hAAAAAAAA;
	#(CLK_PERIOD*2);
	i_ofm = 32'hBBBBBBBB;
	#(CLK_PERIOD*2);
	i_ofm = 32'hCCCCCCCC;
	#(CLK_PERIOD*2);
	i_ofm = 32'hDDDDDDDD;
	#(CLK_PERIOD*2);
	i_ofm = 32'hEEEEEEEE;
	#(CLK_PERIOD*2);
	i_ofm = 32'hFFFFFFFF;
end

endmodule