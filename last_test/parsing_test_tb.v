`timescale 1ns/ 1ns

module parsing_test_tb();

reg clk, rstn, iStart;
// Clock
parameter CLK_PERIOD = 10;	//100MHz
initial begin
	clk = 1'b1;
	forever #(CLK_PERIOD/2) clk = ~clk;
end

/*for Test wire*/
reg [15:0] i_ena;		// enable for write address
reg [8:0] i_addra;	// input address for write
reg [15:0] i_wea;		// input write enable
reg [127:0] i_dia;		// input write data

reg [72:0] iWeight[0:11];
reg [15:0] iBias[0:3];

wire [7:0] oLayer[0:3];

layer00 layer00(
	.clk(clk),
	.rstn(rstn),
	.iStart(iStart),

	/*for Test wire*/
	.i_ena(i_ena),		// enable for write address
	.i_addra(i_addra),	// input address for write
	.i_wea(i_wea),		// input write enable
	.i_dia(i_dia),		// input write data

	.iBias0(iBias[0]),
	.iBias1(iBias[1]),
	.iBias2(iBias[2]),
	.iBias3(iBias[3]),

	.oLayer0_0(oLayer[0]),
	.oLayer0_1(oLayer[1]),
    .oLayer0_2(oLayer[2]),
    .oLayer0_3(oLayer[3])
);


parameter IFM00_DATA_SIZE  = 256*256;	
parameter IFM_FILE_00 = "C:/yolohw/sim/inout_data_sw/log_feamap/input_feature_map.hex"; 
parameter BIAS_FILE_15 = "C:/yolohw/sim/inout_data_sw/log_param/CONV00_param_biases.hex";
reg  [31:0] in_img[0:IFM00_DATA_SIZE-1];  // Infmap
reg  [15:0] r_Bias[0:15];  // Bias
 
integer i,j,k;
initial begin: PROC_SimmemLoad
	// Inputs
	for (i = 0; i< IFM00_DATA_SIZE; i=i+1) begin
		in_img[i] = 0;
	end
	for(i=0; i<16; i=i+1) begin
		r_Bias[i] = 0;
	end
	$display ("Loading input feature maps from file: %s", IFM_FILE_00);
	$readmemh(IFM_FILE_00, in_img);
	for (i = 0; i< 100; i=i+1) begin
		$display ("%x", in_img[i]);
	end
	$display ("Loading bias from file: %s", BIAS_FILE_15 );
	$readmemh(BIAS_FILE_15, r_Bias);
end


reg[7:0] test_probe;
initial begin
	rstn = 1'b0;
	#10;
	rstn = 1'b1;
	iStart = 1'b0;
	
	test_probe = 1'b0;// for debug
	j=0; 
	k=0;
	/*bram init*/
	i_ena = 16'b0000_0000_0000_0001;
	i_wea = 16'b0000_0000_0000_0001;
	#10;
	@(posedge clk);
	for(i = 0; i< 128; i = i + 1) begin
		@(posedge clk);
		i_addra = i;
		i_dia = in_img[j];
		j = j + 1;
	end
	@(posedge clk);//k=0 end

	for(k = 1; k < 16; k = k + 1) begin
		i_ena = i_ena << 1;
		i_wea = i_ena;
		#10;
		@(posedge clk);
		for(i = 0; i< 128; i = i + 1) begin
			@(posedge clk);
			i_addra = i;
			i_dia = in_img[j];
			j = j + 1;
		end
		@(posedge clk);
	end

	// Bias
	for(i=0;i<4;i=i+1) begin
		iBias[i] = r_Bias[i];
	end

	iStart = 1'b1;

end

always @(oLayer[0]) begin
	test_probe = oLayer[0];
end

endmodule