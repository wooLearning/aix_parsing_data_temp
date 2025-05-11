`timescale 1ns/ 1ns

module mac_tb();
	
reg clk, rstn, vld_i;

reg [7:0] iDin[0:15];

reg [7:0] iWeight[0:8];

reg [15:0] iBias;

wire [7:0] oOut;

mac mac(
    .clk(clk), 
    .rstn(rstn), 
    .vld_i(vld_i), 

    .iDin0(iDin[0]),
	.iDin1(iDin[1]),
	.iDin2(iDin[2]),
	.iDin3(iDin[3]),
	.iDin4(iDin[4]),
	.iDin5(iDin[5]),
	.iDin6(iDin[6]),
	.iDin7(iDin[7]),
	.iDin8(iDin[8]),
	.iDin9(iDin[9]),
	.iDin10(iDin[10]),
	.iDin11(iDin[11]),
	.iDin12(iDin[12]),
	.iDin13(iDin[13]),
	.iDin14(iDin[14]),
	.iDin15(iDin[15]),

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

// Clock
parameter CLK_PERIOD = 10;	//100MHz
initial begin
	clk = 1'b1;
	forever #(CLK_PERIOD/2) clk = ~clk;
end

integer i=0;

reg [19:0] y0;
reg [19:0] y1;
reg [19:0] y2;
reg [19:0] y3;

initial begin
	rstn = 1'b0;
	#10;
	rstn = 1'b1;
	vld_i = 1'b0;

	iBias = 100;

	for(i=0;i<9;i=i+1)begin
		iWeight[i] = 8'h2;
	end
	for(i=1;i<17;i=i+1) begin
		iDin[i-1] = i;
	end

	#100;
	@(posedge clk);
	@(posedge clk);
	vld_i = 1'b1;

end

integer j;
initial begin
	y0 = 0;
	y1 = 0;
	y2 = 0;
	y3 = 0;

	for(j=0;j<3;j=j+1)begin
	/*mac 결과 확인1*/
	for(i=1;i<4;i=i+1) begin
		y0 = y0 + i*2;
	end
	for(i=5;i<8;i=i+1) begin
		y0 = y0 + i*2;
	end
	for(i=9;i<12;i=i+1) begin
		y0 = y0 + i*2;
	end

	/*mac 결과 확인2*/
	for(i=2;i<5;i=i+1) begin
		y1 = y1 + i*2;
	end
	for(i=6;i<9;i=i+1) begin
		y1 = y1 + i*2;
	end
	for(i=10;i<13;i=i+1) begin
		y1 = y1 + i*2;
	end

	/*mac 결과 확인3*/
	for(i=5;i<8;i=i+1) begin
		y2 = y2 + i*2;
	end
	for(i=9;i<12;i=i+1) begin
		y2 = y2 + i*2;
	end
	for(i=13;i<16;i=i+1) begin
		y2 = y2 + i*2;
	end

	/*mac 결과 확인4*/
	for(i=6;i<9;i=i+1) begin
		y3 = y3 + i*2;
	end
	for(i=10;i<13;i=i+1) begin
		y3 = y3 + i*2;
	end
	for(i=14;i<17;i=i+1) begin
		y3 = y3 + i*2;
	end
	end

end

endmodule