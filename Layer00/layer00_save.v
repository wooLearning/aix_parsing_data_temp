module layer00_save (
	input clk, 
	input rstn, 
	input i_vld,

	input [31:0] i_ofm,

	output [127:0] o_ifm,

	output [9:0] o_addr0,
	output [9:0] o_addr1,
	output [9:0] o_addr2,
	output [9:0] o_addr3,
	output [9:0] o_addr4,
	output [9:0] o_addr5,
	output [9:0] o_addr6,
	output [9:0] o_addr7,
	output [9:0] o_addr8,
	output [9:0] o_addr9,
	output [9:0] o_addr10,
	output [9:0] o_addr11,
	output [9:0] o_addr12,
	output [9:0] o_addr13,
	output [9:0] o_addr14,
	output [9:0] o_addr15,

	output [15:0] o_cs// chip select
);

integer i;

reg [4:0] rMuxCnt;
always @(posedge clk, negedge rstn) begin
	if(!rstn) begin
		rMuxCnt <= 5'b1;
	end
	else if(i_vld) begin
		rMuxCnt <= (rMuxCnt << 1);
	end
	else if(rMuxCnt == 5'b01000) begin
		rMuxCnt <= (rMuxCnt << 1);
	end
	else if(rMuxCnt == 5'b10000) begin
		rMuxCnt <= 5'b1;
	end
	else begin
		rMuxCnt <= rMuxCnt;
	end
end

reg [31:0] r_data[0:3];
wire [31:0] wMuxOut[0:3];

always @(posedge clk, negedge rstn) begin
	if(!rstn) begin
		for(i=0;i<4;i=i+1) begin
			r_data[i] <= 32'd0;
		end
	end
	else begin
		for(i=0;i<4;i=i+1) begin
			r_data[i] <= wMuxOut[i];
		end
	end
end

assign wMuxOut[0] = (rMuxCnt[0] == 1'b1) ? i_ofm : r_data[0];
assign wMuxOut[1] = (rMuxCnt[1] == 1'b1) ? i_ofm : r_data[1];
assign wMuxOut[2] = (rMuxCnt[2] == 1'b1) ? i_ofm : r_data[2];
assign wMuxOut[3] = (rMuxCnt[3] == 1'b1) ? i_ofm : r_data[3];


assign o_ifm = {r_data[3], r_data[2], r_data[1], r_data[0]};

reg	[8:0] addr_cnt;//8 or 9 bit
always @(posedge clk, negedge rstn) begin
	if(!rstn) begin
		addr_cnt <= 0;
	end
	else if(rMuxCnt[4]) begin
		addr_cnt <= addr_cnt + 1'b1;
	end
	else begin
		addr_cnt <= addr_cnt;
	end
end

assign o_addr0 = addr_cnt[8:2];
assign o_addr1 = addr_cnt[8:2];
assign o_addr2 = addr_cnt[8:2];
assign o_addr3 = addr_cnt[8:2];
assign o_addr4 = addr_cnt[8:2];
assign o_addr5 = addr_cnt[8:2];
assign o_addr6 = addr_cnt[8:2];
assign o_addr7 = addr_cnt[8:2];
assign o_addr8 = addr_cnt[8:2];
assign o_addr9 = addr_cnt[8:2];
assign o_addr10 = addr_cnt[8:2];
assign o_addr11 = addr_cnt[8:2];
assign o_addr12 = addr_cnt[8:2];
assign o_addr13 = addr_cnt[8:2];
assign o_addr14 = addr_cnt[8:2];
assign o_addr15 = addr_cnt[8:2];



endmodule