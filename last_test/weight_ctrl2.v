module weight_ctrl2 #(
    parameter KERNEL_WIDTH  = 72
)(
	input clk,
    input rstn,
    input i_cal,

	output  [KERNEL_WIDTH-1:0]  o_kernel0, // main outputs
    output  [KERNEL_WIDTH-1:0]  o_kernel1,
    output  [KERNEL_WIDTH-1:0]  o_kernel2,

    output  [KERNEL_WIDTH-1:0]  o_kernel3,
    output  [KERNEL_WIDTH-1:0]  o_kernel4,
    output  [KERNEL_WIDTH-1:0]  o_kernel5,

    output  [KERNEL_WIDTH-1:0]  o_kernel6,
    output  [KERNEL_WIDTH-1:0]  o_kernel7,
    output  [KERNEL_WIDTH-1:0]  o_kernel8,

    output  [KERNEL_WIDTH-1:0]  o_kernel9,
    output  [KERNEL_WIDTH-1:0]  o_kernel10,
    output  [KERNEL_WIDTH-1:0]  o_kernel11
);
	
// parameter ADDR_WIDTH = 32;
parameter BUFF_DEPTH    = 4096;
parameter BUFF_ADDR_W   = $clog2(BUFF_DEPTH);
parameter WEIGHT_BITS   = 2;

// memory address to calculate the lines
//        WEIGHT_DATA_SIZE = Fx*Fy*Ni*No;
parameter KERNEL_DATA_COUNT_CONV00 = 3*3*3*16 / 9;       // 432/9 = 48
parameter KERNEL_DATA_COUNT_CONV02 = 3*3*16*32 / 9;      // 4,608/9 = 512
parameter KERNEL_DATA_COUNT_CONV04 = 3*3*32*64 / 9;      // 18,432/9 = 2,048

//-------------------------------------------------
// Internal signals
//-------------------------------------------------
wire    [KERNEL_WIDTH-1:0]  w_wfetcher;         // kernel fetcher
wire    [BUFF_ADDR_W-1:0]   w_rom_addr;
wire                        w_cs;               // ROM enable signal

//-------------------------------------------------
// spram_4096x72
//-------------------------------------------------
spram_wrapper #(
    .DEPTH                      (BUFF_DEPTH     ),
    .AW                         (BUFF_ADDR_W    ),
    .DW                         (KERNEL_WIDTH   ))
u_data_buffer(    
    ./*input    [AW-1:0]*/clk   (clk          ),
    ./*input            */addr   (w_rom_addr    ),
    ./*input            */we    (1'b0           ),  // Always Read -> because it's a rom
    ./*input            */cs    (w_cs           ),  
    ./*input    [DW-1:0]*/wdata   (0/* dont care */),  // We can't write to the ROM
    ./*output   [DW-1:0]*/rdata (w_wfetcher     )   // weight fetching [72 bits]
);
integer i;
reg    [KERNEL_WIDTH-1:0]  r_kernel[0:48];
always @(posedge clk, negedge rstn) begin
	if(!rstn) begin
		for(i=0;i<48;i=i+1) begin
			r_kernel[i] <= 0;
		end
	end

end




reg    [BUFF_ADDR_W-1:0]   r_rom_addr;




reg    [3:0]               r_kernel_idx;       // max 0~11 idx (# of MACs)
always @(posedge clk, negedge rstn) begin
	if(!rstn) begin
		r_kernel_idx <= 4'b0;
	end
	else if(i_load_en) begin
		
	end
	else begin
		r_kernel_idx <= r_kernel_idx + 1'b1;
	end
end

endmodule