`timescale 1ns / 1ps

module mac(
input clk, 
input rstn, 
input vld_i, 
input [127:0] win, 
input [127:0] din,
output[ 19:0] acc_o, 
output        vld_o
);

//----------------------------------------------------------------------
// Signals
//----------------------------------------------------------------------
wire[15:0] y00;
wire[15:0] y01;
wire[15:0] y02;
wire[15:0] y03;
wire[15:0] y04;
wire[15:0] y05;
wire[15:0] y06;
wire[15:0] y07;
wire[15:0] y08;
wire[15:0] y09;
wire[15:0] y10;
wire[15:0] y11;
wire[15:0] y12;
wire[15:0] y13;
wire[15:0] y14;
wire[15:0] y15;

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
//----------------------------------------------------------------------
// Adder tree
//----------------------------------------------------------------------
adder_tree u_adder_tree(
./*input 		*/clk(clk), 
./*input 		*/rstn(rstn),
./*input 		*/vld_i(vld_i_d4),
./*input [15:0] */mul_00(y00), 
./*input [15:0] */mul_01(y01), 
./*input [15:0] */mul_02(y02), 
./*input [15:0] */mul_03(y03), 
./*input [15:0] */mul_04(y04), 
./*input [15:0] */mul_05(y05), 
./*input [15:0] */mul_06(y06), 
./*input [15:0] */mul_07(y07),
./*input [15:0] */mul_08(y08), 
./*input [15:0] */mul_09(y09), 
./*input [15:0] */mul_10(y10), 
./*input [15:0] */mul_11(y11),
./*input [15:0] */mul_12(y12), 
./*input [15:0] */mul_13(y13), 
./*input [15:0] */mul_14(y14), 
./*input [15:0] */mul_15(y15),
./*output[19:0] */acc_o(acc_o),
./*output       */vld_o(vld_o) 
);
endmodule
