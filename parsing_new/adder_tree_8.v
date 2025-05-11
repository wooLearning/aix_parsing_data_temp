`timescale 1ns / 1ps

module adder_tree_8(
input clk, 
input rstn,
input vld_i,
input [15:0] mul_00, 
input [15:0] mul_01, 
input [15:0] mul_02, 
input [15:0] mul_03, 
input [15:0] mul_04, 
input [15:0] mul_05, 
input [15:0] mul_06, 
input [15:0] mul_07,
output[18:0] acc_o,
output       vld_o 
);

//----------------------------------------------------------------------
// Signals
//----------------------------------------------------------------------
// Level 1
reg [16:0] y1_0;
reg [16:0] y1_1;
reg [16:0] y1_2;
reg [16:0] y1_3;
// Level 2
reg [17:0] y2_0;
reg [17:0] y2_1;
// Level 3
reg [18:0] y3_0;

// Delays
reg vld_i_d1, vld_i_d2, vld_i_d3;
//-------------------------------------------------
// Reduction tree
//-------------------------------------------------
// Level 1
always@(posedge clk, negedge rstn) begin
	if(!rstn) begin
		y1_0 <= 17'd0;
		y1_1 <= 17'd0;
		y1_2 <= 17'd0;
		y1_3 <= 17'd0;
	end
	else begin 
		y1_0 <= $signed(mul_00) + $signed(mul_01);
		y1_1 <= $signed(mul_02) + $signed(mul_03);
		y1_2 <= $signed(mul_04) + $signed(mul_05);
		y1_3 <= $signed(mul_06) + $signed(mul_07);	
	end
end

// Level 2
always@(posedge clk, negedge rstn) begin
	if(!rstn) begin
		y2_0 <= 18'd0;
		y2_1 <= 18'd0;
	end
	else begin 
		y2_0 <= $signed(y1_0) + $signed(y1_1);
		y2_1 <= $signed(y1_2) + $signed(y1_3);
	end
end

// Level 3
always@(posedge clk, negedge rstn) begin
	if(!rstn) begin
		y3_0 <= 19'd0;
	end
	else begin 
		y3_0 <= $signed(y2_0) + $signed(y2_1);
	end
end

//-------------------------------------------------
// Valid signal
//-------------------------------------------------
always@(posedge clk, negedge rstn) begin
	if(!rstn) begin
		vld_i_d1 <= 0;
		vld_i_d2 <= 0;
		vld_i_d3 <= 0;
	end
	else begin 
		vld_i_d1 <= vld_i   ;
		vld_i_d2 <= vld_i_d1;
		vld_i_d3 <= vld_i_d2;
	end
end
//Output
assign vld_o = vld_i_d3;
assign acc_o = $signed(y3_0);
endmodule
