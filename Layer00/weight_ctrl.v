`timescale 1ns / 1ps

module weight_ctrl #(
    parameter KERNEL_WIDTH  = 72
) (
    input                       clk,
    input                       rstn,
    input                       i_load_en,                       
    
    // ROM interface (for layer 0,2,4)
    output                      o_ready,// enable signal from SangWook


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

// parameter ADDR_WIDTH = 32;
parameter BUFF_DEPTH    = 4096;
parameter BUFF_ADDR_W   = $clog2(BUFF_DEPTH);
parameter WEIGHT_BITS   = 2;

// memory address to calculate the lines
//        WEIGHT_DATA_SIZE = Fx*Fy*Ni*No;
parameter KERNEL_DATA_COUNT_CONV00 = 3*3*3*16 / 9;       // 432/9 = 48
parameter KERNEL_DATA_COUNT_CONV02 = 3*3*16*32 / 9;      // 4,608/9 = 512
parameter KERNEL_DATA_COUNT_CONV04 = 3*3*32*64 / 9;      // 18,432/9 = 2,048
// AXI ports


//-------------------------------------------------
// Internal signals
//-------------------------------------------------
wire    [KERNEL_WIDTH-1:0]  w_wfetcher;         // kernel fetcher
wire    [BUFF_ADDR_W-1:0]   w_rom_addr;
wire                        w_cs;               // ROM enable signal

reg     [BUFF_ADDR_W-1:0]   r_rom_addr;
reg                         r_cs;
reg     [3:0]               r_kernel_idx;       // max 0~11 idx (# of MACs)
reg                         r_ready;

// kernel sets {{{
reg     [KERNEL_WIDTH-1:0]  r_kernel0;
reg     [KERNEL_WIDTH-1:0]  r_kernel1;
reg     [KERNEL_WIDTH-1:0]  r_kernel2;

reg     [KERNEL_WIDTH-1:0]  r_kernel3;
reg     [KERNEL_WIDTH-1:0]  r_kernel4;
reg     [KERNEL_WIDTH-1:0]  r_kernel5;

reg     [KERNEL_WIDTH-1:0]  r_kernel6;
reg     [KERNEL_WIDTH-1:0]  r_kernel7;
reg     [KERNEL_WIDTH-1:0]  r_kernel8;

reg     [KERNEL_WIDTH-1:0]  r_kernel9;
reg     [KERNEL_WIDTH-1:0]  r_kernel10;
reg     [KERNEL_WIDTH-1:0]  r_kernel11;
//}}}

// State {{{
localparam  IDLE            =   2'b00,
            LOAD_CONV       =   2'b01,
            LOAD_WAIT       =   2'b10,
            DONE            =   2'b11;
reg     [ 1:0]              r_cstate;
reg     [ 1:0]              r_nstate;
//}}}

assign  w_rom_addr = r_rom_addr;
assign  w_cs       = r_cs;
//-------------------------------------------------
// FSM
//-------------------------------------------------

// State transition
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        r_cstate <= IDLE;
    end else begin
        r_cstate <= r_nstate;
    end
end

// Next state logic (combinational)
always @(*) begin
    case (r_cstate)
    IDLE: begin
        if (i_load_en) begin
            if (r_rom_addr == 0) begin
                r_nstate = LOAD_CONV;
            end else begin
                r_nstate = IDLE;
            end
        end
        else begin
            r_nstate    = IDLE;
        end
    end

    LOAD_CONV: begin
        if ((r_rom_addr == KERNEL_DATA_COUNT_CONV00 - 1) ||     // wait if weights are ready
            (r_rom_addr == KERNEL_DATA_COUNT_CONV02 - 1) ||
            (r_rom_addr == KERNEL_DATA_COUNT_CONV04 - 1)) begin
            r_nstate    = LOAD_WAIT;
        end else begin
            r_nstate    = LOAD_CONV;
        end
    end
    
    LOAD_WAIT: begin
        if (i_load_en) begin
            if ((r_rom_addr == KERNEL_DATA_COUNT_CONV00 - 1) ||
                (r_rom_addr == KERNEL_DATA_COUNT_CONV02 - 1)) begin
                r_nstate    = LOAD_CONV;
            end else if (r_rom_addr == KERNEL_DATA_COUNT_CONV04 - 1) begin
                r_nstate    = DONE;
            end
        end else begin
            r_nstate    = LOAD_WAIT;    // wait till the load signal comes in
        end
    end

    DONE: begin
        r_nstate = IDLE;
    end
        
    default: r_nstate = IDLE;
    endcase
end

// Output and control logic
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        r_kernel_idx    <= 0;
        r_rom_addr      <= 0;
        r_cs            <= 0;
        r_ready         <= 0;
        r_kernel0       <= 0;
        r_kernel1       <= 0;
        r_kernel2       <= 0;
        r_kernel3       <= 0;
        r_kernel4       <= 0;
        r_kernel5       <= 0;
        r_kernel6       <= 0;
        r_kernel7       <= 0;
        r_kernel8       <= 0;        
        r_kernel9       <= 0;
        r_kernel10      <= 0;
        r_kernel11      <= 0;
    end
    
    else begin
        case (r_cstate)
            IDLE: begin
                if (i_load_en) begin 
                    r_ready     <= 0;
                    r_cs        <= 0;
                end
            end

            LOAD_CONV: begin              // fetching weights to r_kernel#s
                r_cs        <= 1'b1;
                r_ready     <= 0;
                case (r_kernel_idx)
                    4'd0:  r_kernel0  <= w_wfetcher;
                    4'd1:  r_kernel1  <= w_wfetcher;
                    4'd2:  r_kernel2  <= w_wfetcher;
                    4'd3:  r_kernel3  <= w_wfetcher;
                    4'd4:  r_kernel4  <= w_wfetcher;
                    4'd5:  r_kernel5  <= w_wfetcher;
                    4'd6:  r_kernel6  <= w_wfetcher;
                    4'd7:  r_kernel7  <= w_wfetcher;
                    4'd8:  r_kernel8  <= w_wfetcher;
                    4'd9:  r_kernel9  <= w_wfetcher;
                    4'd10: r_kernel10 <= w_wfetcher;
                    4'd11: r_kernel11 <= w_wfetcher;
                    default: ;
                endcase

                r_kernel_idx    <= r_kernel_idx + 1;
                r_rom_addr      <= r_rom_addr + 1;
            end
            // weight_rom.coe
            // 13 f5 fa 3d ef d6 17 fe eb --> 1 kernel (72 bits)
            // ...

            LOAD_WAIT: begin    // if the load signal comes in, tranfer weights / then we can obtain the weights right after the load signal of the master.
                r_cs            <= 0;       // turn off the rom to prohibit a misfetching during the wait
                r_kernel_idx    <= 0;
                r_ready         <= 1;
            end
            
            DONE: begin
                r_kernel0       <= 0;
                r_kernel1       <= 0;
                r_kernel2       <= 0;
                r_kernel3       <= 0;
                r_kernel4       <= 0;
                r_kernel5       <= 0;
                r_kernel6       <= 0;
                r_kernel7       <= 0;
                r_kernel8       <= 0;
                r_kernel9       <= 0;
                r_kernel10      <= 0;
                r_kernel11      <= 0;

                r_rom_addr      <= 0;
                r_kernel_idx    <= 0;
                r_ready         <= 0;
                r_cs            <= 0;
            end
        endcase
    end
end

//-------------------------------------------------
// spram_4096x72
//-------------------------------------------------
spram_wrapper #(
    .DEPTH                      (BUFF_DEPTH     ),
    .AW                         (BUFF_ADDR_W    ),
    .DW                         (KERNEL_WIDTH   ))
u_data_buffer(    
    ./*input    [AW-1:0]*/clk   (clk          ),
    ./*input            */addr   (w_rom_addr     ),
    ./*input            */we    (1'b0           ),  // Always Read -> because it's a rom
    ./*input            */cs    (w_cs           ),  
    ./*input    [DW-1:0]*/wdata   (0/* dont care */),  // We can't write to the ROM
    ./*output   [DW-1:0]*/rdata (w_wfetcher     )   // weight fetching [72 bits]
);

//-------------------------------------------------
// Output assignments
//-------------------------------------------------
assign  o_kernel0    = r_kernel0;
assign  o_kernel1    = r_kernel1;
assign  o_kernel2    = r_kernel2;
assign  o_kernel3    = r_kernel3;
assign  o_kernel4    = r_kernel4;
assign  o_kernel5    = r_kernel5;
assign  o_kernel6    = r_kernel6;
assign  o_kernel7    = r_kernel7;
assign  o_kernel8    = r_kernel8;
assign  o_kernel9    = r_kernel9;
assign  o_kernel10   = r_kernel10;
assign  o_kernel11   = r_kernel11;

assign  o_ready      = r_ready;

endmodule