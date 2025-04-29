`timescale 1ns / 1ps

module mac(
    input clk, 
    input rstn, 
    input vld_i, //parsing data랑 타이밍 보고 거기서 신호 뽑아줘야할 듯

    input [7:0] iDin0,
	input [7:0] iDin1,
	input [7:0] iDin2,
	input [7:0] iDin3,
	input [7:0] iDin4,
	input [7:0] iDin5,
	input [7:0] iDin6,
	input [7:0] iDin7,
	input [7:0] iDin8,
	input [7:0] iDin9,
	input [7:0] iDin10,
	input [7:0] iDin11,
	input [7:0] iDin12,
	input [7:0] iDin13,
	input [7:0] iDin14,
	input [7:0] iDin15,

	input [7:0] iWeight0,
	input [7:0] iWeight1,
	input [7:0] iWeight2,
	input [7:0] iWeight3,
	input [7:0] iWeight4,
	input [7:0] iWeight5,
	input [7:0] iWeight6,
	input [7:0] iWeight7,

    output[7:0] oOut
);

reg vld_i_d0, vld_i_d1, vld_i_d2, vld_i_d3, vld_i_d4;

//----------------------------------------------------------------------
// Components: Array of multipliers
//----------------------------------------------------------------------

////////////
/*weight0*/
///////////
mul mul0_0(
    .clk(clk),
    .a(iDin0),
    .b(iDin1),  
    .c(iWeight0), 
    .ac(wmul_out0[0]),
    .bc(wmul_out1[0])
);
mul mul0_1(
    .clk(clk),
    .a(iDin4),
    .b(iDin5),  
    .c(iWeight0), 
    .ac(wmul_out2[0]),
    .bc(wmul_out3[0])
);

////////////
/*weight1*/
///////////
mul mul1_0(
    .clk(clk),
    .a(iDin1),
    .b(iDin2),  
    .c(iWeight1), 
    .ac(wmul_out0[1]),
    .bc(wmul_out1[1])
);
mul mul1_1(
    .clk(clk),
    .a(iDin5),
    .b(iDin6),  
    .c(iWeight1), 
    .ac(wmul_out2[1]),
    .bc(wmul_out3[1])
);

////////////
/*weight2*/
///////////
mul mul2_0(
    .clk(clk),
    .a(iDin2),
    .b(iDin3),  
    .c(iWeight2), 
    .ac(wmul_out0[2]),
    .bc(wmul_out1[2])
);
mul mul2_1(
    .clk(clk),
    .a(iDin6),
    .b(iDin7),  
    .c(iWeight2), 
    .ac(wmul_out2[2]),
    .bc(wmul_out3[2])
);

////////////
/*weight3*/
///////////
mul mul3_0(
    .clk(clk),
    .a(iDin4),
    .b(iDin5),  
    .c(iWeight3), 
    .ac(wmul_out0[3]),
    .bc(wmul_out1[3])
);
mul mul3_1(
    .clk(clk),
    .a(iDin8),
    .b(iDin9),  
    .c(iWeight3), 
    .ac(wmul_out2[3]),
    .bc(wmul_out3[3])
);

////////////
/*weight4*/
///////////
mul mul4_0(
    .clk(clk),
    .a(iDin5),
    .b(iDin6),  
    .c(iWeight4), 
    .ac(wmul_out0[4]),
    .bc(wmul_out1[4])
);
mul mul4_1(
    .clk(clk),
    .a(iDin9),
    .b(iDin10),  
    .c(iWeight4), 
    .ac(wmul_out2[4]),
    .bc(wmul_out3[4])
);

////////////
/*weight5*/
///////////
mul mul5_0(
    .clk(clk),
    .a(iDin6),
    .b(iDin7),  
    .c(iWeight5), 
    .ac(wmul_out0[5]),
    .bc(wmul_out1[5])
);
mul mul5_1(
    .clk(clk),
    .a(iDin10),
    .b(iDin11),  
    .c(iWeight5), 
    .ac(wmul_out2[5]),
    .bc(wmul_out3[5])
);

////////////
/*weight6*/
///////////
mul mul6_0(
    .clk(clk),
    .a(iDin8),
    .b(iDin9),  
    .c(iWeight6), 
    .ac(wmul_out0[6]),
    .bc(wmul_out1[6])
);
mul mul6_1(
    .clk(clk),
    .a(iDin12),
    .b(iDin13),  
    .c(iWeight6), 
    .ac(wmul_out2[6]),
    .bc(wmul_out3[6])
);

////////////
/*weight7*/
///////////
mul mul7_0(
    .clk(clk),
    .a(iDin9),
    .b(iDin10),  
    .c(iWeight7), 
    .ac(wmul_out0[7]),
    .bc(wmul_out1[7])
);
mul mul7_1(
    .clk(clk),
    .a(iDin13),
    .b(iDin14),  
    .c(iWeight7), 
    .ac(wmul_out2[7]),
    .bc(wmul_out3[7])
);

////////////
/*weight8*/
///////////
mul mul8_0(
    .clk(clk),
    .a(iDin10),
    .b(iDin11),  
    .c(iWeight8), 
    .ac(wmul_out0[8]),
    .bc(wmul_out1[8])
);
mul mul8_1(
    .clk(clk),
    .a(iDin14),
    .b(iDin15),  
    .c(iWeight8), 
    .ac(wmul_out2[8]),
    .bc(wmul_out3[8])
);

//----------------------------------------------------------------------
// Delays
//----------------------------------------------------------------------
always@(posedge clk, negedge rstn) begin
	if(!rstn) begin
	    vld_i_d0 <= 0;
		vld_i_d1 <= 0;
		vld_i_d2 <= 0;
		vld_i_d3 <= 0;
		vld_i_d4 <= 0;
	end
	else begin 
		vld_i_d0 <= vld_i   ;
		vld_i_d1 <= vld_i_d0;
		vld_i_d2 <= vld_i_d1;
		vld_i_d3 <= vld_i_d2;
		vld_i_d4 <= vld_i_d3;	
	end
end


wire[19:0] w_acc_o[0:3];
wire w_vld_o;//input timing 생각해야함
//----------------------------------------------------------------------
// Adder tree
//----------------------------------------------------------------------
adder_tree u_adder_tree0(
./*input 		*/clk(clk), 
./*input 		*/rstn(rstn),
./*input 		*/vld_i(vld_i_d4),
./*input [15:0] */mul_00(wmul_out0[0]), 
./*input [15:0] */mul_01(wmul_out0[1]), 
./*input [15:0] */mul_02(wmul_out0[2]), 
./*input [15:0] */mul_03(wmul_out0[3]), 
./*input [15:0] */mul_04(wmul_out0[4]), 
./*input [15:0] */mul_05(wmul_out0[5]), 
./*input [15:0] */mul_06(wmul_out0[6]), 
./*input [15:0] */mul_07(wmul_out0[7]),
./*input [15:0] */mul_08(wmul_out0[8]), 
./*output[19:0] */acc_o(w_acc_o[0]),
./*output       */vld_o(w_vld_o) 
);

adder_tree u_adder_tree1(
./*input 		*/clk(clk), 
./*input 		*/rstn(rstn),
./*input 		*/vld_i(vld_i_d4),
./*input [15:0] */mul_00(wmul_out1[0]), 
./*input [15:0] */mul_01(wmul_out1[1]), 
./*input [15:0] */mul_02(wmul_out1[2]), 
./*input [15:0] */mul_03(wmul_out1[3]), 
./*input [15:0] */mul_04(wmul_out1[4]), 
./*input [15:0] */mul_05(wmul_out1[5]), 
./*input [15:0] */mul_06(wmul_out1[6]), 
./*input [15:0] */mul_07(wmul_out1[7]),
./*input [15:0] */mul_08(wmul_out1[8]), 
./*output[19:0] */acc_o(w_acc_o[1]),
./*output       */vld_o(w_vld_o) 
);

adder_tree u_adder_tree2(
./*input 		*/clk(clk), 
./*input 		*/rstn(rstn),
./*input 		*/vld_i(vld_i_d4),
./*input [15:0] */mul_00(wmul_out2[0]), 
./*input [15:0] */mul_01(wmul_out2[1]), 
./*input [15:0] */mul_02(wmul_out2[2]), 
./*input [15:0] */mul_03(wmul_out2[3]), 
./*input [15:0] */mul_04(wmul_out2[4]), 
./*input [15:0] */mul_05(wmul_out2[5]), 
./*input [15:0] */mul_06(wmul_out2[6]), 
./*input [15:0] */mul_07(wmul_out2[7]),
./*input [15:0] */mul_08(wmul_out2[8]), 
./*output[19:0] */acc_o(w_acc_o[2]),
./*output       */vld_o(w_vld_o) 
);

adder_tree u_adder_tree3(
./*input 		*/clk(clk), 
./*input 		*/rstn(rstn),
./*input 		*/vld_i(vld_i_d4),
./*input [15:0] */mul_00(wmul_out3[0]), 
./*input [15:0] */mul_01(wmul_out3[1]), 
./*input [15:0] */mul_02(wmul_out3[2]), 
./*input [15:0] */mul_03(wmul_out3[3]), 
./*input [15:0] */mul_04(wmul_out3[4]), 
./*input [15:0] */mul_05(wmul_out3[5]), 
./*input [15:0] */mul_06(wmul_out3[6]), 
./*input [15:0] */mul_07(wmul_out3[7]),
./*input [15:0] */mul_08(wmul_out3[8]), 
./*output[19:0] */acc_o(w_acc_o[3]),
./*output       */vld_o(w_vld_o) 
);



//-----------------
// Delays
//-----------------
reg rD1, rD2, rD3, rD4;
wire wAccDelay = rD1 || rD2 || rD3 || rD4;
always@(posedge clk, negedge rstn) begin
	if(!rstn) begin
		rD1 <= 0;
		rD2 <= 0;
		rD3 <= 0;
		rD4 <= 0;
	end
	else begin 
		rD1 <= w_vld_o;
		rD2 <= rD1;
		rD3 <= rD2;
		rD4 <= rD3;	
	end
end

integer i;
/*accumulator*/
reg [31:0] r_acc[0:3];
always @(posedge clk, negedge rstn) begin
    if(!rstn) begin
        for(i=0;i<4;i=i+1)begin
            r_acc[i] <= 32'b0;
        end
    end
    else if(wAccDelay) begin
        for(i=0;i<4;i=i+1)begin
            r_acc[i] <= r_acc + w_acc_o[i];
        end
    end
    else begin
        for(i=0;i<4;i=i+1)begin
            r_acc[i] <= 32'b0;
        end
    end
end

// Activation + Quantization (Descaling)
//enable signal 정의 아직 안함
wire [31:0] wSum_act[0:3];
wSum_act[0] = (D4) ? ((r_acc[0][31]==1)?0:r_acc[0]): 0;
wSum_act[1] = (D4) ? ((r_acc[1][31]==1)?0:r_acc[1]): 0;
wSum_act[2] = (D4) ? ((r_acc[2][31]==1)?0:r_acc[2]): 0;
wSum_act[3] = (D4) ? ((r_acc[3][31]==1)?0:r_acc[3]): 0;

wire [7:0] wDes[0:3];
wDes[0] = (D4) ? ((wSum_act[0][31:7]>255)?255:wSum_act[0][14:7]):0; // Descaling: * 1/2^11	
wDes[1] = (D4) ? ((wSum_act[1][31:7]>255)?255:wSum_act[1][14:7]):0; // Descaling: * 1/2^11	
wDes[2] = (D4) ? ((wSum_act[2][31:7]>255)?255:wSum_act[2][14:7]):0; // Descaling: * 1/2^11	
wDes[3] = (D4) ? ((wSum_act[3][31:7]>255)?255:wSum_act[3][14:7]):0; // Descaling: * 1/2^11

/*max pooling*/
wire [7:0] wMax0, wMax1, wMaxFinal;

assign wMax0 = (wDes[0] > wDes[1]) ? wDes[0] : wDes[1];
assign wMax1 = (wDes[2] > wDes[3]) ? wDes[2] : wDes[3];
assign oOut = (wMax0 > wMax1) ? wMax0 : wMax1;



endmodule
