module mac_bank_last (
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
	input [127:0] iDin8,
	input [127:0] iDin9,
	input [127:0] iDin10,
	input [127:0] iDin11,

	input [72:0] iWeight0,//mac_num
	input [72:0] iWeight1,
	input [72:0] iWeight2,
	input [72:0] iWeight3,
	input [72:0] iWeight4,
	input [72:0] iWeight5,
	input [72:0] iWeight6,
	input [72:0] iWeight7,
	input [72:0] iWeight8,
	input [72:0] iWeight9,
	input [72:0] iWeight10,
	input [72:0] iWeight11,

	input [15:0] iBias,

);

wire [127:0] w_iDin[0:11];
wire [72:0] w_iWeight[0:11];


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

wire [19:0] oOut[0:11];

genvar i;
generate
    for (i = 0; i < 12; i = i + 1) begin : mac_inst
        mac mac_inst (
            .clk(clk), 
            .rstn(rstn), 
            .vld_i(vld_i), 
            .iDin(iDin[i]),
            .iWeight(iWeight[i]),
            .oOut0(wout[i]),
        );
    end
endgenerate


endmodule