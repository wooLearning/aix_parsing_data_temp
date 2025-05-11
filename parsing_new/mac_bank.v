module mac_bank (
	input clk, 
    input rstn, 
    input vld_i, 

	input [127:0] iDin0,
	input [127:0] iDin1,
	input [127:0] iDin2,
	input [127:0] iDin3,
	input [127:0] iDin4,
	input [127:0] iDin5,
	input [127:0] iDin6,
	input [127:0] iDin7,

	input [72:0] iWeight0,
	input [72:0] iWeight1,
	input [72:0] iWeight2,
	input [72:0] iWeight3,
	input [72:0] iWeight4,
	input [72:0] iWeight5,
	input [72:0] iWeight6,
	input [72:0] iWeight7,

	input [15:0] iBias,

);

wire [127:0] w_iDin[0:7];
wire [72:0] w_iWeight[0:7];

wire [19:0] wout0[0:7];
wire [19:0] wout1[0:7];
wire [19:0] wout2[0:7];
wire [19:0] wout3[0:7];

assign w_iDin[0] = iDin0;
assign w_iDin[1] = iDin1;
assign w_iDin[2] = iDin2;
assign w_iDin[3] = iDin3;
assign w_iDin[4] = iDin4;
assign w_iDin[5] = iDin5;
assign w_iDin[6] = iDin6;
assign w_iDin[7] = iDin7;

assign w_iWeight[0] = iWeight0;
assign w_iWeight[1] = iWeight1;
assign w_iWeight[2] = iWeight2;
assign w_iWeight[3] = iWeight3;
assign w_iWeight[4] = iWeight4;
assign w_iWeight[5] = iWeight5;
assign w_iWeight[6] = iWeight6;
assign w_iWeight[7] = iWeight7;


genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : mac_inst
        mac mac_inst (
            .clk(clk), 
            .rstn(rstn), 
            .vld_i(vld_i), 
            .iDin(iDin[i]),
            .iWeight(iWeight[i]),
            .oOut0(wout0[i]),
			.oOut1(wout1[i]),
			.oOut2(wout2[i]),
			.oOut3(wout3[i])
        );
    end
endgenerate

//adder tree for channel
reg [18:0] r_acc0;
reg [18:0] r_acc1;
reg [18:0] r_acc2;
reg [18:0] r_acc3;
wire w_tree_vld;

adder_tree_8 adder_tree_0(
	.clk(clk), 
	.rstn(rstn), 
	.vld_i(vld_i), 
	.mul_00(wout0[0]), 
	.mul_01(wout0[1]), 
	.mul_02(wout0[2]), 
	.mul_03(wout0[3]), 
	.mul_04(wout0[4]), 
	.mul_05(wout0[5]), 
	.mul_06(wout0[6]), 
	.mul_07(wout0[7]),
	.acc_o(r_acc0),//18bit
	.vld_o(w_tree_vld)
);
adder_tree_8 adder_tree_1(
	.clk(clk), 
	.rstn(rstn), 
	.vld_i(vld_i), 
	.mul_00(wout1[0]), 
	.mul_01(wout1[1]), 
	.mul_02(wout1[2]), 
	.mul_03(wout1[3]), 
	.mul_04(wout1[4]), 
	.mul_05(wout1[5]), 
	.mul_06(wout1[6]), 
	.mul_07(wout1[7]),
	.acc_o(r_acc1),//18bit
	.vld_o(w_tree_vld)
);
adder_tree_8 adder_tree_2(
	.clk(clk), 
	.rstn(rstn), 
	.vld_i(vld_i), 
	.mul_00(wout2[0]), 
	.mul_01(wout2[1]), 
	.mul_02(wout2[2]), 
	.mul_03(wout2[3]), 
	.mul_04(wout2[4]), 
	.mul_05(wout2[5]), 
	.mul_06(wout2[6]), 
	.mul_07(wout2[7]),
	.acc_o(r_acc2),//18bit
	.vld_o(w_tree_vld)
);
adder_tree_8 adder_tree_3(
	.clk(clk), 
	.rstn(rstn), 
	.vld_i(vld_i), 
	.mul_00(wout3[0]), 
	.mul_01(wout3[1]), 
	.mul_02(wout3[2]), 
	.mul_03(wout3[3]), 
	.mul_04(wout3[4]), 
	.mul_05(wout3[5]), 
	.mul_06(wout3[6]), 
	.mul_07(wout3[7]),
	.acc_o(r_acc3),//18bit
	.vld_o(w_tree_vld)
);







always @(posedge clk, negedge rstn) begin
    if(!rstn) begin
        for(i=0;i<4;i=i+1)begin
            r_acc[i] <= 32'b0;
        end
    end
	for(i=0;i<8;i=i+1)begin
        r_acc[i] <= r_acc[i] + wout0[i];
		r_acc[i] <= r_acc[i] + wout1[i];
		r_acc[i] <= r_acc[i] + wout2[i];
		r_acc[i] <= r_acc[i] + wout3[i];
    end
end

// Activation + Quantization (Descaling)
//enable signal 정의 아직 안함
wire [31:0] wSum_act[0:3];
assign wSum_act[0] = (rD5) ? ((r_acc[0][31]==1)?0:r_acc[0]): 0;
assign wSum_act[1] = (rD5) ? ((r_acc[1][31]==1)?0:r_acc[1]): 0;
assign wSum_act[2] = (rD5) ? ((r_acc[2][31]==1)?0:r_acc[2]): 0;
assign wSum_act[3] = (rD5) ? ((r_acc[3][31]==1)?0:r_acc[3]): 0;

wire [7:0] wDes[0:3];
assign wDes[0] = (rD5) ? ((wSum_act[0][31:7]>255)?255:wSum_act[0][14:7]):0; // Descaling: * 1/2^11	
assign wDes[1] = (rD5) ? ((wSum_act[1][31:7]>255)?255:wSum_act[1][14:7]):0; // Descaling: * 1/2^11	
assign wDes[2] = (rD5) ? ((wSum_act[2][31:7]>255)?255:wSum_act[2][14:7]):0; // Descaling: * 1/2^11	
assign wDes[3] = (rD5) ? ((wSum_act[3][31:7]>255)?255:wSum_act[3][14:7]):0; // Descaling: * 1/2^11

/*max pooling*/
wire [7:0] wMax0, wMax1;																																																									

assign wMax0 = (wDes[0] > wDes[1]) ? wDes[0] : wDes[1];
assign wMax1 = (wDes[2] > wDes[3]) ? wDes[2] : wDes[3];
assign oOut = (wMax0 > wMax1) ? wMax0 : wMax1;




endmodule


// mac mac0(
//     .clk(clk), 
//     .rstn(rstn), 
//     .vld_i(vld_i), 
//     .iDin(iDin0),
//     .iWeight(iWeight0),
//     .iBias(iBias),
//     .oOut(wout0)
// );
// mac mac1(
//     .clk(clk), 
//     .rstn(rstn), 
//     .vld_i(vld_i), 
//     .iDin(iDin1),
//     .iWeight(iWeight1),
//     .iBias(iBias),
//     .oOut(wout1)
// );
// mac mac1(
//     .clk(clk), 
//     .rstn(rstn), 
//     .vld_i(vld_i), 
//     .iDin(iDin1),
//     .iWeight(iWeight1),
//     .iBias(iBias),
//     .oOut(wout1)
// );
// mac mac2(
//     .clk(clk), 
//     .rstn(rstn), 
//     .vld_i(vld_i), 
//     .iDin(iDin2),
//     .iWeight(iWeight2),
//     .iBias(iBias),
//     .oOut(wout2)
// );
// mac mac3(
//     .clk(clk), 
//     .rstn(rstn), 
//     .vld_i(vld_i), 
//     .iDin(iDin3),
//     .iWeight(iWeight3),
//     .iBias(iBias),
//     .oOut(wout3)
// );
// mac mac4(
//     .clk(clk), 
//     .rstn(rstn), 
//     .vld_i(vld_i), 
//     .iDin(iDin4),
//     .iWeight(iWeight4),
//     .iBias(iBias),
//     .oOut(wout4)
// );