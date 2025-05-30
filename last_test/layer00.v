module layer00 (
	input clk, 
	input rstn, 
	input iStart,

	/*for Test wire*/
	input [15:0] i_ena,		// enable for write address
	input [8:0] i_addra,	// input address for write
	input [15:0] i_wea,		// input write enable
	input [127:0] i_dia,		// input write data
	
	input [1:0] i_layerInfo,

	output[31:0] oLayer_result,

	output oLayer_vld 
);

wire [127:0] oDin0;
wire [127:0] oDin1;
wire [127:0] oDin2;

wire w_oMac_vld;

parsing_top_layer00 parsing(
	.clk(clk),
	.rstn(rstn),
	.iStart(iStart),

	.i_ena(i_ena),
	.i_addra(i_addra),
	.i_wea(i_wea),
	.i_dia(i_dia),

	/* AFTER ZERO PADDING */
	.oDin0(oDin0),//r
	.oDin1(oDin1),//g
	.oDin2(oDin2),//b

	.oMac_vld(w_oMac_vld)
);


wire [71:0] iWeight[0:11];

weight_ctrl#(.KERNEL_WIDTH(72)) 
weight_ctrl(
	.clk(clk),
	.rstn(rstn),
	.i_load_en(w_oMac_vld),

	.o_ready(o_ready),

	// each kernel has 9 weights (9*8=72 bits)
   	.o_kernel0(iWeight[0]), // main outputs
	.o_kernel1(iWeight[1]),
	.o_kernel2(iWeight[2]),
	.o_kernel3(iWeight[3]),
	.o_kernel4(iWeight[4]),
	.o_kernel5(iWeight[5]),
	.o_kernel6(iWeight[6]),
	.o_kernel7(iWeight[7]),
	.o_kernel8(iWeight[8]),
	.o_kernel9(iWeight[9]),
	.o_kernel10(iWeight[10]),
	.o_kernel11(iWeight[11])
);

wire wMac_vld = w_oMac_vld && o_ready;

wire [127:0] wBank_iDin[0:11];

assign wBank_iDin[0] = (i_layerInfo == 2'b00) ? oDin0 : 0;//0 is parsing2 output



wire [19:0] oOut0[0:11];
wire [19:0] oOut1[0:11];
wire [19:0] oOut2[0:11];
wire [19:0] oOut3[0:11];

mac_bank mac_bank(
	.clk(clk), 
    .rstn(rstn), 
    .vld_i(wMac_vld), 

	.iDin0(oDin0),//r
	.iDin1(oDin1),//g
	.iDin2(oDin2),//b

	.iDin3(oDin0),
	.iDin4(oDin1),
	.iDin5(oDin2),

	.iDin6(oDin0),
	.iDin7(oDin1),
	.iDin8(oDin2),

	.iDin9(oDin0),
	.iDin10(oDin1),
	.iDin11(oDin2),

	.iWeight0(iWeight[0]),
	.iWeight1(iWeight[1]),
	.iWeight2(iWeight[2]),
	.iWeight3(iWeight[3]),
	.iWeight4(iWeight[4]),
	.iWeight5(iWeight[5]),
	.iWeight6(iWeight[6]),
	.iWeight7(iWeight[7]),
	.iWeight8(iWeight[8]),
	.iWeight9(iWeight[9]),
	.iWeight10(iWeight[10]),
	.iWeight11(iWeight[11]),

	.oOut0_0(oOut0[0]),
	.oOut0_1(oOut1[0]),
	.oOut0_2(oOut2[0]),
	.oOut0_3(oOut3[0]),

	.oOut1_0(oOut0[1]),
	.oOut1_1(oOut1[1]),
	.oOut1_2(oOut2[1]),
	.oOut1_3(oOut3[1]),

	.oOut2_0(oOut0[2]),
	.oOut2_1(oOut1[2]),
	.oOut2_2(oOut2[2]),
	.oOut2_3(oOut3[2]),

	.oOut3_0(oOut0[3]),
	.oOut3_1(oOut1[3]),
	.oOut3_2(oOut2[3]),
	.oOut3_3(oOut3[3]),

	.oOut4_0(oOut0[4]),
	.oOut4_1(oOut1[4]),
	.oOut4_2(oOut2[4]),
	.oOut4_3(oOut3[4]),

	.oOut5_0(oOut0[5]),
	.oOut5_1(oOut1[5]),
	.oOut5_2(oOut2[5]),
	.oOut5_3(oOut3[5]),

	.oOut6_0(oOut0[6]),
	.oOut6_1(oOut1[6]),
	.oOut6_2(oOut2[6]),
	.oOut6_3(oOut3[6]),

	.oOut7_0(oOut0[7]),
	.oOut7_1(oOut1[7]),
	.oOut7_2(oOut2[7]),
	.oOut7_3(oOut3[7]),

	.oOut8_0(oOut0[8]),
	.oOut8_1(oOut1[8]),
	.oOut8_2(oOut2[8]),
	.oOut8_3(oOut3[8]),

	.oOut9_0(oOut0[9]),
	.oOut9_1(oOut1[9]),
	.oOut9_2(oOut2[9]),
	.oOut9_3(oOut3[9]),

	.oOut10_0(oOut0[10]),
	.oOut10_1(oOut1[10]),
	.oOut10_2(oOut2[10]),
	.oOut10_3(oOut3[10]),

	.oOut11_0(oOut0[11]),//[mac number]
	.oOut11_1(oOut1[11]),
	.oOut11_2(oOut2[11]),
	.oOut11_3(oOut3[11])

);

reg vld_i_d1, vld_i_d2, vld_i_d3, vld_i_d4;
always@(posedge clk, negedge rstn) begin
	if(!rstn) begin
		vld_i_d1 <= 0;
		vld_i_d2 <= 0;
		vld_i_d3 <= 0;
		vld_i_d4 <= 0;
	end
	else begin 
		vld_i_d1 <= wMac_vld;
		vld_i_d2 <= vld_i_d1;
		vld_i_d3 <= vld_i_d2;
		vld_i_d4 <= vld_i_d3;	
	end
end

wire [63:0] w_bias;
bias_ctrl bias_ctrl(
	.clk(clk),
	.rstn(rstn),
	.i_vld(vld_i_d3),
	.i_cs(w_oMac_vld),
	.o_bias(w_bias)
);
wire [15:0] iBias0 = w_bias[0+:16];
wire [15:0] iBias1 = w_bias[16+:16];
wire [15:0] iBias2 = w_bias[32+:16];
wire [15:0] iBias3 = w_bias[48+:16];

wire w_add_vld0, w_add_vld1, w_add_vld2, w_add_vld3;//wire
wire [22:0] w_after_add0[0:3];
wire [22:0] w_after_add1[0:3];
wire [22:0] w_after_add2[0:3];
wire [22:0] w_after_add3[0:3];

adder_tree2 addertree2_0(//filter 0
	.clk(clk),
	.rstn(rstn),
	.vld_i(vld_i_d4),

	.iOut0(oOut0[0]),
	.iOut1(oOut0[1]),
	.iOut2(oOut0[2]),

	.iOut3(oOut1[0]),
	.iOut4(oOut1[1]),
	.iOut5(oOut1[2]),

	.iOut6(oOut2[0]),
	.iOut7(oOut2[1]),
	.iOut8(oOut2[2]),

	.iOut9(oOut3[0]),
	.iOut10(oOut3[1]),
	.iOut11(oOut3[2]),

	.iBias(iBias0),

	.oOut0(w_after_add0[0]),
	.oOut1(w_after_add0[1]),
	.oOut2(w_after_add0[2]),
	.oOut3(w_after_add0[3]),

	.add_vld(w_add_vld0)
);

adder_tree2 addertree2_1(//filter 1
	.clk(clk),
	.rstn(rstn),
	.vld_i(vld_i_d4),

	.iOut0(oOut0[3]),
	.iOut1(oOut0[4]),
	.iOut2(oOut0[5]),

	.iOut3(oOut1[3]),
	.iOut4(oOut1[4]),
	.iOut5(oOut1[5]),

	.iOut6(oOut2[3]),
	.iOut7(oOut2[4]),
	.iOut8(oOut2[5]),

	.iOut9(oOut3[3]),
	.iOut10(oOut3[4]),
	.iOut11(oOut3[5]),

	.iBias(iBias1),

	.oOut0(w_after_add1[0]),
	.oOut1(w_after_add1[1]),
	.oOut2(w_after_add1[2]),
	.oOut3(w_after_add1[3]),

	.add_vld(w_add_vld1)
);
adder_tree2 addertree2_2(//filter 2
	.clk(clk),
	.rstn(rstn),
	.vld_i(vld_i_d4),

	.iOut0(oOut0[6]),
	.iOut1(oOut0[7]),
	.iOut2(oOut0[8]),

	.iOut3(oOut1[6]),
	.iOut4(oOut1[7]),
	.iOut5(oOut1[8]),

	.iOut6(oOut2[6]),
	.iOut7(oOut2[7]),
	.iOut8(oOut2[8]),

	.iOut9(oOut3[6]),
	.iOut10(oOut3[7]),
	.iOut11(oOut3[8]),

	.iBias(iBias2),

	.oOut0(w_after_add2[0]),
	.oOut1(w_after_add2[1]),
	.oOut2(w_after_add2[2]),
	.oOut3(w_after_add2[3]),

	.add_vld(w_add_vld2)
);
adder_tree2 addertree2_3(//filter 3
	.clk(clk),
	.rstn(rstn),
	.vld_i(vld_i_d4),

	.iOut0(oOut0[9]),
	.iOut1(oOut0[10]),
	.iOut2(oOut0[11]),

	.iOut3(oOut1[9]),
	.iOut4(oOut1[10]),
	.iOut5(oOut1[11]),

	.iOut6(oOut2[9]),
	.iOut7(oOut2[10]),
	.iOut8(oOut2[11]),

	.iOut9(oOut3[9]),
	.iOut10(oOut3[10]),
	.iOut11(oOut3[11]),

	.iBias(iBias3),

	.oOut0(w_after_add3[0]),
	.oOut1(w_after_add3[1]),
	.oOut2(w_after_add3[2]),
	.oOut3(w_after_add3[3]),

	.add_vld(w_add_vld3)
);

wire [7:0] oLayer0_0; 
wire [7:0] oLayer0_1; 
wire [7:0] oLayer0_2; 
wire [7:0] oLayer0_3; 

additional_layer00 addLayer0(
	.clk(clk), 
    .rstn(rstn), 
    .i_vld(w_add_vld0), 
	
	.in0(w_after_add0[0]),
	.in1(w_after_add0[1]),
	.in2(w_after_add0[2]),
	.in3(w_after_add0[3]),

	.oOut(oLayer0_0)
);
additional_layer00 addLayer1(
	.clk(clk), 
	.rstn(rstn), 
	.i_vld(w_add_vld1), 
	
	.in0(w_after_add1[0]),
	.in1(w_after_add1[1]),
	.in2(w_after_add1[2]),
	.in3(w_after_add1[3]),

	.oOut(oLayer0_1)
);
additional_layer00 addLayer2(
	.clk(clk), 
	.rstn(rstn), 
	.i_vld(w_add_vld2), 
	
	.in0(w_after_add2[0]),
	.in1(w_after_add2[1]),
	.in2(w_after_add2[2]),
	.in3(w_after_add2[3]),

	.oOut(oLayer0_2)
);
additional_layer00 addLayer3(
	.clk(clk), 
	.rstn(rstn), 
	.i_vld(w_add_vld3), 
	
	.in0(w_after_add3[0]),
	.in1(w_after_add3[1]),
	.in2(w_after_add3[2]),
	.in3(w_after_add3[3]),

	.oOut(oLayer0_3)
);
assign oLayer_result = {oLayer0_3,oLayer0_2,oLayer0_1,oLayer0_0};

assign oLayer_vld =  w_add_vld0;

wire o_bram_en;
wire [15:0] o_bram_cs;

wire [5:0] o_bram_addr[0:15];
wire [127:0] o_bram_data[0:15];

dma_conv_02  dma_conv_02( 

	.i_clk(clk),
	.i_rstn(rstn),
    .i_cal_fin(oLayer_vld),

    .i_bram_data(oLayer_result),

    .o_bram_en(o_bram_en),
    .o_bram_cs(o_bram_cs),
    .o_bram_addr_00(o_bram_addr[0]),
    .o_bram_addr_01(o_bram_addr[1]),
    .o_bram_addr_02(o_bram_addr[2]),
    .o_bram_addr_03(o_bram_addr[3]),
    .o_bram_addr_04(o_bram_addr[4]),
    .o_bram_addr_05(o_bram_addr[5]),
    .o_bram_addr_06(o_bram_addr[6]),
    .o_bram_addr_07(o_bram_addr[7]),
    .o_bram_addr_08(o_bram_addr[8]),
    .o_bram_addr_09(o_bram_addr[9]),
    .o_bram_addr_10(o_bram_addr[10]),
    .o_bram_addr_11(o_bram_addr[11]),
    .o_bram_addr_12(o_bram_addr[12]),
    .o_bram_addr_13(o_bram_addr[13]),
    .o_bram_addr_14(o_bram_addr[14]),
    .o_bram_addr_15(o_bram_addr[15]),

    .o_bram_data_00(o_bram_data[0]),
    .o_bram_data_01(o_bram_data[1]),
    .o_bram_data_02(o_bram_data[2]),
    .o_bram_data_03(o_bram_data[3]),
    .o_bram_data_04(o_bram_data[4]),
    .o_bram_data_05(o_bram_data[5]),
    .o_bram_data_06(o_bram_data[6]),
    .o_bram_data_07(o_bram_data[7]),
    .o_bram_data_08(o_bram_data[8]),
    .o_bram_data_09(o_bram_data[9]),
    .o_bram_data_10(o_bram_data[10]),
    .o_bram_data_11(o_bram_data[11]),
    .o_bram_data_12(o_bram_data[12]),
    .o_bram_data_13(o_bram_data[13]),
    .o_bram_data_14(o_bram_data[14]),
    .o_bram_data_15(o_bram_data[15])

);


endmodule