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
    
endmodule