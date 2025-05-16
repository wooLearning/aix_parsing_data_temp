module weight_ctrl #(
    parameter KERNEL_WIDTH  = 72
) (
    input                       clk,
    input                       rstn,
    input                       i_load_en,                       
    
    output o_ready,

    // each kernel has 9 weights (9*8=72 bits)
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

    // AXI ports        // not implemented yet
);
    

integer i;

localparam ADDR_WIDTH = 5;
reg [ADDR_WIDTH-1:0] addr_cnt;

reg [71:0] weight[0:11];
wire [71:0] w_rom[0:3];

reg r_vld0, r_vld1;// delay 2clk

always @(posedge clk) begin
    if(!rstn) begin
        for(i=0; i<12; i=i+1) begin
            weight[i] <= 72'b0;
        end
    end
   else if(i_load_en)begin
        /*mac1*/
        weight[2] <= w_rom[0];
        weight[1] <= weight[2];
        weight[0] <= weight[1];

        /*mac2*/
        weight[5] <= w_rom[1];
        weight[4] <= weight[5];
        weight[3] <= weight[4];

        /*mac3*/
        weight[8] <= w_rom[2];
        weight[7] <= weight[8];
        weight[6] <= weight[7];

        /*mac4*/
        weight[11] <= w_rom[3];
        weight[10] <= weight[11];
        weight[9] <= weight[10];

    end
    else begin
        for(i=0; i<12; i=i+1) begin
            weight[i] <= 0;
        end
    end
end

//addr counter register
always @(posedge clk, negedge rstn) begin
    if(!rstn) begin
        addr_cnt <= 0;
    end 
    else if(!i_load_en) begin
        addr_cnt <= 0;
    end
    else if(r_vld1) begin
        addr_cnt <= addr_cnt + 1'b1;
    end
end

always @(posedge clk, negedge rstn) begin
    if(!rstn) begin
        r_vld0 <=0;
        r_vld1 <=0;
    end
    else if(i_load_en) begin
        r_vld0 <= i_load_en;
        r_vld1 <= r_vld0;
    end
    else begin
        r_vld0 <=0;
        r_vld1 <=0;
    end
end

wire w_cs = i_load_en;
wire [9:0] w_rom_addr;
assign w_rom_addr = {6'b0,addr_cnt[3:0]};
assign o_ready = (addr_cnt==5) || (addr_cnt==8) || (addr_cnt==11) ||(addr_cnt==14) ;

// main outputs
assign o_kernel0 = weight[0];
assign o_kernel1 = weight[1];
assign o_kernel2 = weight[2];

assign o_kernel3 = weight[3];
assign o_kernel4 = weight[4];
assign o_kernel5 = weight[5];

assign o_kernel6 = weight[6];
assign o_kernel7 = weight[7];
assign o_kernel8 = weight[8];

assign o_kernel9 = weight[9];
assign o_kernel10 = weight[10];
assign o_kernel11 = weight[11];

generate
rom_1024x72_0 u_rom_1024x72_0( 
    // write
    .clka(clk),
    .ena(w_cs ),
    .wea(1'b0  ),
    .addra(w_rom_addr ),
    .dina(0),//don't care for this rom 
    // read-out
    .douta(w_rom[0])
);
rom_1024x72_1 u_rom_1024x72_1( 
    // write
    .clka(clk),
    .ena(w_cs ),
    .wea(1'b0  ),
    .addra(w_rom_addr ),
    .dina(0),//don't care for this rom 
    // read-out
    .douta(w_rom[1])
);
rom_1024x72_2 u_rom_1024x72_2( 
    // write
    .clka(clk),
    .ena(w_cs ),
    .wea(1'b0  ),
    .addra(w_rom_addr ),
    .dina(0),//don't care for this rom 
    // read-out
    .douta(w_rom[2])
);
rom_1024x72_3 u_rom_1024x72_3( 
    // write
    .clka(clk),
    .ena(w_cs ),
    .wea(1'b0  ),
    .addra(w_rom_addr ),
    .dina(0),//don't care for this rom 
    // read-out
    .douta(w_rom[3])
);
endgenerate


endmodule