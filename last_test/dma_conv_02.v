//----------------------------------------------------------------------------------------------------------------+
//----------------------------------------------------------------------------------------------------------------+
// Project: AIX 2025
// Module: dma_conv_02.v
// Description:
//      Address control module for CNN (Only read from MAC to Grobal_Buf-B)
//
// History: 2025.05.15 
//----------------------------------------------------------------------------------------------------------------+

module dma_conv_02 #(                           
    parameter ADDR_WIDTH        = 6,
    parameter BUF_NUM           = 16,
    parameter MAC_DATA_WD       = 32,
    parameter BRAM_DATA_WD      = 128

) ( input                       i_clk,
    input                       i_rstn,
    
    input                       i_cal_fin,
    input   [MAC_DATA_WD-1:0 ]  i_bram_data,

    output                      o_bram_en,
    output  [BUF_NUM-1:0     ]  o_bram_cs,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_00,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_01,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_02,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_03,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_04,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_05,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_06,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_07,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_08,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_09,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_10,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_11,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_12,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_13,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_14,
    output  [ADDR_WIDTH-1:0  ]  o_bram_addr_15,

    output  [BRAM_DATA_WD-1:0]  o_bram_data_00,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_01,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_02,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_03,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_04,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_05,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_06,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_07,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_08,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_09,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_10,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_11,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_12,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_13,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_14,
    output  [BRAM_DATA_WD-1:0]  o_bram_data_15

);


//-----------------------------------------------------------------------------------------------------------------
// Define
//-----------------------------------------------------------------------------------------------------------------
    // Define Reg
    reg                     r_mux_en;
    reg                     r_bram_en;  
    reg                     r_pixel_done;
    reg                     r_buf_state; 
    reg  [1:0]              r_mk_data;
    reg  [3:0]              r_pixel_num;
    reg  [4:0]              r_store_cnt;
    reg  [BUF_NUM-1:0    ]  r_bram_cs;
    reg  [MAC_DATA_WD-1:0]  r_data_00;
    reg  [MAC_DATA_WD-1:0]  r_data_01;
    reg  [MAC_DATA_WD-1:0]  r_data_02;
    reg  [MAC_DATA_WD-1:0]  r_data_03;

    // Define Wire
    wire [ADDR_WIDTH-1:0  ] w_bram_addr;
    wire [BRAM_DATA_WD-1:0] w_bram_data;
    wire                    w_mk_data;


//-----------------------------------------------------------------------------------------------------------------
// Assignment
//-----------------------------------------------------------------------------------------------------------------
    assign  w_bram_addr     = {r_buf_state, r_store_cnt};
    assign  w_bram_data     = {r_data_03, r_data_02, r_data_01, r_data_00};
    assign  o_bram_en       = r_bram_en;
    assign  o_bram_cs       = r_bram_cs;


//-----------------------------------------------------------------------------------------------------------------
// Operation
//-----------------------------------------------------------------------------------------------------------------
    // Operation configuration (r_mk_data)
    always @(posedge i_clk or negedge i_rstn)   begin
        if(!i_rstn)
            r_mk_data   <= 2'b0;
            
        else if(i_cal_fin)
            r_mk_data   <= r_mk_data + 1;

        else
            r_mk_data   <= r_mk_data;

    end


    // Operation configuration (r_data & r_mux_en)
    always @(posedge i_clk or negedge i_rstn)   begin
        if(!i_rstn) begin
            r_data_00   <= 32'b0;
            r_data_01   <= 32'b0;
            r_data_02   <= 32'b0;
            r_data_03   <= 32'b0;
            r_mux_en    <=  1'b0;
        end

        else        begin    
            case (r_mk_data)
                2'd0 :  begin   r_data_00 <= i_bram_data; 
                                r_mux_en  <= 1'b0;
                        end

                2'd1 :  begin   r_data_01 <= i_bram_data; 
                                r_mux_en  <= 1'b0;
                        end

                2'd2 :  begin   r_data_02 <= i_bram_data; 
                                r_mux_en  <= 1'b0;
                        end

                2'd3 :  begin   r_data_03 <= i_bram_data; 
                                r_mux_en  <= 1'b1;
                        end

            endcase
        end

    end


    // Operation configuration (r_bram_en)
    always @(posedge i_clk or negedge i_rstn)   begin
        if(!i_rstn)
            r_bram_en   <= 1'b0;
            
        else if((i_cal_fin) && (r_mux_en))
            r_bram_en   <= 1'b1;

        else
            r_bram_en   <= 1'b0;

    end


    // Operation configuration (r_bram_cs)                                          
    always @(posedge i_clk or negedge i_rstn)   begin
        if(!i_rstn)
            r_bram_cs <= 16'h0000;

        else if(r_mux_en) begin
            case(r_pixel_num)
                4'd0   :   r_bram_cs <= 16'b0000_0000_0000_0001;
                4'd1   :   r_bram_cs <= 16'b0000_0000_0000_0010;
                4'd2   :   r_bram_cs <= 16'b0000_0000_0000_0100;
                4'd3   :   r_bram_cs <= 16'b0000_0000_0000_1000;
                4'd4   :   r_bram_cs <= 16'b0000_0000_0001_0000;
                4'd5   :   r_bram_cs <= 16'b0000_0000_0010_0000;
                4'd6   :   r_bram_cs <= 16'b0000_0000_0100_0000;
                4'd7   :   r_bram_cs <= 16'b0000_0000_1000_0000;
                4'd8   :   r_bram_cs <= 16'b0000_0001_0000_0000;
                4'd9   :   r_bram_cs <= 16'b0000_0010_0000_0000;
                4'd10  :   r_bram_cs <= 16'b0000_0100_0000_0000;
                4'd11  :   r_bram_cs <= 16'b0000_1000_0000_0000;
                4'd12  :   r_bram_cs <= 16'b0001_0000_0000_0000;
                4'd13  :   r_bram_cs <= 16'b0010_0000_0000_0000;
                4'd14  :   r_bram_cs <= 16'b0100_0000_0000_0000;
                4'd15  :   r_bram_cs <= 16'b1000_0000_0000_0000;

            endcase

        end

        else
            r_bram_cs <= 16'h0000;

    end


    // Operation configuration (r_store_cnt)
    always @(posedge i_clk or negedge i_rstn)   begin
        if(!i_rstn)
            r_store_cnt <= 5'b0;
            
        else if(r_bram_en)
            r_store_cnt <= r_store_cnt + 1;

        else
            r_store_cnt <= r_store_cnt;

    end


    // Operation configuration (r_pixel_num & r_pixel_done)
    always @(posedge i_clk or negedge i_rstn)   begin
        if(!i_rstn)                                                         begin
            r_pixel_num     <= 4'b0;
            r_pixel_done    <= 1'b0;
        end
            
        else if((r_store_cnt == 5'd31) && (!r_pixel_done) && (r_bram_en))   begin
            r_pixel_num     <= r_pixel_num + 1;
            r_pixel_done    <= 1'b1;
        end

        else                                                                begin
            r_pixel_num     <= r_pixel_num;
            r_pixel_done    <= 1'b0;
        end

    end


    // Operation configuration (r_buf_state)
    always @(posedge i_clk or negedge i_rstn)   begin
        if(!i_rstn)
            r_buf_state <= 1'b0;
            
        else if((r_bram_cs) && (r_pixel_num == 4'd15) && (r_store_cnt == 5'd31))
            r_buf_state <= ~r_buf_state;

        else
            r_buf_state <= r_buf_state;

    end


    // Operation configuration (o_bram_addr)
    assign o_bram_addr_00   = (r_pixel_num == 4'd0 ) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_01   = (r_pixel_num == 4'd1 ) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_02   = (r_pixel_num == 4'd2 ) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_03   = (r_pixel_num == 4'd3 ) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_04   = (r_pixel_num == 4'd4 ) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_05   = (r_pixel_num == 4'd5 ) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_06   = (r_pixel_num == 4'd6 ) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_07   = (r_pixel_num == 4'd7 ) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_08   = (r_pixel_num == 4'd8 ) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_09   = (r_pixel_num == 4'd9 ) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_10   = (r_pixel_num == 4'd10) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_11   = (r_pixel_num == 4'd11) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_12   = (r_pixel_num == 4'd12) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_13   = (r_pixel_num == 4'd13) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_14   = (r_pixel_num == 4'd14) ? w_bram_addr[5:0] : 6'b0;
    assign o_bram_addr_15   = (r_pixel_num == 4'd15) ? w_bram_addr[5:0] : 6'b0;


    // Operation configuration (o_bram_data)
    assign o_bram_data_00   = (r_pixel_num == 4'd0 ) ? w_bram_data : 32'b0;
    assign o_bram_data_01   = (r_pixel_num == 4'd1 ) ? w_bram_data : 32'b0;
    assign o_bram_data_02   = (r_pixel_num == 4'd2 ) ? w_bram_data : 32'b0;
    assign o_bram_data_03   = (r_pixel_num == 4'd3 ) ? w_bram_data : 32'b0;
    assign o_bram_data_04   = (r_pixel_num == 4'd4 ) ? w_bram_data : 32'b0;
    assign o_bram_data_05   = (r_pixel_num == 4'd5 ) ? w_bram_data : 32'b0;
    assign o_bram_data_06   = (r_pixel_num == 4'd6 ) ? w_bram_data : 32'b0;
    assign o_bram_data_07   = (r_pixel_num == 4'd7 ) ? w_bram_data : 32'b0;
    assign o_bram_data_08   = (r_pixel_num == 4'd8 ) ? w_bram_data : 32'b0;
    assign o_bram_data_09   = (r_pixel_num == 4'd9 ) ? w_bram_data : 32'b0;
    assign o_bram_data_10   = (r_pixel_num == 4'd10) ? w_bram_data : 32'b0;
    assign o_bram_data_11   = (r_pixel_num == 4'd11) ? w_bram_data : 32'b0;
    assign o_bram_data_12   = (r_pixel_num == 4'd12) ? w_bram_data : 32'b0;
    assign o_bram_data_13   = (r_pixel_num == 4'd13) ? w_bram_data : 32'b0;
    assign o_bram_data_14   = (r_pixel_num == 4'd14) ? w_bram_data : 32'b0;
    assign o_bram_data_15   = (r_pixel_num == 4'd15) ? w_bram_data : 32'b0;


endmodule