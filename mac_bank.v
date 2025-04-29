module mac_bank (//this is weird code, you don't have to read this code

	input clk,
	input rstn,

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

    input i_acc_valid,

	//next layer input
	output [7:0] oOut
);

wire [15:0] wMac_out0[0:8];//3*3
wire [15:0] wMac_out1[0:8];
wire [15:0] wMac_out2[0:8];
wire [15:0] wMac_out3[0:8];

////////////
/*weight0*/
///////////
mac mac0_0(
    .clk(clk),
    .a(iDin0),
    .b(iDin1),  
    .c(iWeight0), 
    .ac(wMac_out0[0]),
    .bc(wMac_out1[0])
);
mac mac0_1(
    .clk(clk),
    .a(iDin4),
    .b(iDin5),  
    .c(iWeight0), 
    .ac(wMac_out2[0]),
    .bc(wMac_out3[0])
);

////////////
/*weight1*/
///////////
mac mac1_0(
    .clk(clk),
    .a(iDin1),
    .b(iDin2),  
    .c(iWeight1), 
    .ac(wMac_out0[1]),
    .bc(wMac_out1[1])
);
mac mac1_1(
    .clk(clk),
    .a(iDin5),
    .b(iDin6),  
    .c(iWeight1), 
    .ac(wMac_out2[1]),
    .bc(wMac_out3[1])
);

////////////
/*weight2*/
///////////
mac mac2_0(
    .clk(clk),
    .a(iDin2),
    .b(iDin3),  
    .c(iWeight2), 
    .ac(wMac_out0[2]),
    .bc(wMac_out1[2])
);
mac mac2_1(
    .clk(clk),
    .a(iDin6),
    .b(iDin7),  
    .c(iWeight2), 
    .ac(wMac_out2[2]),
    .bc(wMac_out3[2])
);

////////////
/*weight3*/
///////////
mac mac3_0(
    .clk(clk),
    .a(iDin4),
    .b(iDin5),  
    .c(iWeight3), 
    .ac(wMac_out0[3]),
    .bc(wMac_out1[3])
);
mac mac3_1(
    .clk(clk),
    .a(iDin8),
    .b(iDin9),  
    .c(iWeight3), 
    .ac(wMac_out2[3]),
    .bc(wMac_out3[3])
);

////////////
/*weight4*/
///////////
mac mac4_0(
    .clk(clk),
    .a(iDin5),
    .b(iDin6),  
    .c(iWeight4), 
    .ac(wMac_out0[4]),
    .bc(wMac_out1[4])
);
mac mac4_1(
    .clk(clk),
    .a(iDin9),
    .b(iDin10),  
    .c(iWeight4), 
    .ac(wMac_out2[4]),
    .bc(wMac_out3[4])
);

////////////
/*weight5*/
///////////
mac mac5_0(
    .clk(clk),
    .a(iDin6),
    .b(iDin7),  
    .c(iWeight5), 
    .ac(wMac_out0[5]),
    .bc(wMac_out1[5])
);
mac mac5_1(
    .clk(clk),
    .a(iDin10),
    .b(iDin11),  
    .c(iWeight5), 
    .ac(wMac_out2[5]),
    .bc(wMac_out3[5])
);

////////////
/*weight6*/
///////////
mac mac6_0(
    .clk(clk),
    .a(iDin8),
    .b(iDin9),  
    .c(iWeight6), 
    .ac(wMac_out0[6]),
    .bc(wMac_out1[6])
);
mac mac6_1(
    .clk(clk),
    .a(iDin12),
    .b(iDin13),  
    .c(iWeight6), 
    .ac(wMac_out2[6]),
    .bc(wMac_out3[6])
);

////////////
/*weight7*/
///////////
mac mac7_0(
    .clk(clk),
    .a(iDin9),
    .b(iDin10),  
    .c(iWeight7), 
    .ac(wMac_out0[7]),
    .bc(wMac_out1[7])
);
mac mac7_1(
    .clk(clk),
    .a(iDin13),
    .b(iDin14),  
    .c(iWeight7), 
    .ac(wMac_out2[7]),
    .bc(wMac_out3[7])
);

////////////
/*weight8*/
///////////
mac mac8_0(
    .clk(clk),
    .a(iDin10),
    .b(iDin11),  
    .c(iWeight8), 
    .ac(wMac_out0[8]),
    .bc(wMac_out1[8])
);
mac mac8_1(
    .clk(clk),
    .a(iDin14),
    .b(iDin15),  
    .c(iWeight8), 
    .ac(wMac_out2[8]),
    .bc(wMac_out3[8])
);

reg [15:0] rMac_out0[0:8];//3*3
reg [15:0] rMac_out1[0:8];
reg [15:0] rMac_out2[0:8];
reg [15:0] rMac_out3[0:8];

reg [3:0] r_shifter;//3 clock delay


integer i;


//after mac output register
always @(posedge clk, negedge rstn) begin
	if(!rstn)begin
		for(i=0;i<9;i=i+1) begin
			rMac_out0[i] <= 16'b0;
		end
		for(i=0;i<9;i=i+1) begin
			rMac_out1[i] <= 16'b0;
		end
		for(i=0;i<9;i=i+1) begin
			rMac_out2[i] <= 16'b0;
		end
		for(i=0;i<9;i=i+1) begin
			rMac_out3[i] <= 16'b0;
		end
	end
	else begin // accumulator 
		for(i=0;i<9;i=i+1) begin
			rMac_out0[i] <= rMac_out0[i] + wMac_out0[i];
		end
		for(i=0;i<9;i=i+1) begin
			rMac_out1[i] <= rMac_out1[i] + wMac_out1[i];
		end
		for(i=0;i<9;i=i+1) begin
			rMac_out2[i] <= rMac_out2[i] + wMac_out2[i];
		end
		for(i=0;i<9;i=i+1) begin
			rMac_out3[i] <= rMac_out3[i] + wMac_out3[i];
		end
	end
end

always @(posedge clk, negedge rstn) begin
    if(!rstn) begin
        r_shifter <= 0;
    end
    else if(i_acc_valid) begin
        r_shifter[0] <= i_acc_valid;
        r_shifter[1] <= r_shifter[0];
        r_shifter[2] <= r_shifter[1];
        r_shifter[3] <= r_shifter[2];
    end
    else begin
        r_shifter <= 0;
    end
end


endmodule

