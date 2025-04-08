module parsing_data_layer00 (
    input clk,
    input rstn,
	input iStart,
	input i_run,

	output[15:0] oCs, // chip enable

	output[8:0] oAddr0,
	output[8:0] oAddr1,
	output[8:0] oAddr2,
	output[8:0] oAddr3,
	output[8:0] oAddr4,
	output[8:0] oAddr5,
	output[8:0] oAddr6,
	output[8:0] oAddr7,
	output[8:0] oAddr8,
	output[8:0] oAddr9,
	output[8:0] oAddr10,
	output[8:0] oAddr11,
	output[8:0] oAddr12,
	output[8:0] oAddr13,
	output[8:0] oAddr14,
	output[8:0] oAddr15,

	input [127:0] iData0, //from bram data
	input [127:0] iData1,
	input [127:0] iData2,
	input [127:0] iData3,
	input [127:0] iData4,
	input [127:0] iData5,
	input [127:0] iData6,
	input [127:0] iData7,
	input [127:0] iData8,
	input [127:0] iData9,
	input [127:0] iData10,
	input [127:0] iData11,
	input [127:0] iData12,
	input [127:0] iData13,
	input [127:0] iData14,
	input [127:0] iData15,

	output [7:0] oDin0,
	output [7:0] oDin1,
	output [7:0] oDin2,
	output [7:0] oDin3,
	output [7:0] oDin4,
	output [7:0] oDin5,
	output [7:0] oDin6,
	output [7:0] oDin7,
	output [7:0] oDin8,
	output [7:0] oDin9,
	output [7:0] oDin10,
	output [7:0] oDin11,
	output [7:0] oDin12,
	output [7:0] oDin13,
	output [7:0] oDin14,
	output [7:0] oDin15

);

localparam MAXCOL = 127;//256/2
localparam MAXROW = 127;

localparam ST_IDLE         = 3'b000,
		   ST_ROW0         = 3'b001,
		   ST_ROW_ODD      = 3'b010,
		   ST_ROW_EVEN     = 3'b011,
		   ST_ROW_END      = 3'b100;

parameter windowDelay = 5;
parameter windowDelayWidth = 3;
parameter ACC_CNT = 32;

reg[windowDelayWidth - 1:0] rCnt_delay;
reg rCol_toggle;//2 count

reg [2:0] rCurState;
reg [2:0] rNxtState;

reg [7:0] rRow, rCol;

reg [8:0] rAddr[0:15];

reg [127:0] r_data[0:15];
reg [7:0] r_din[0:15];

reg [4:0] rSplit_cnt;

reg rRow_toggle1;
reg rRow_toggle2;

//-----------------
/*wire declartion*/
//----------------
wire wCol_end;
wire wRow_end;

reg [15:0] wCs;

//-------------------------------------------------
// FSM
//--------------------------------------------------
always @(posedge clk, negedge rstn) begin
    if(!rstn) begin
       rCurState <= ST_IDLE;
    end
    else begin
        rCurState <= rNxtState;
    end
end
always @(*) begin
    case(rCurState)
		ST_IDLE: begin
			if(iStart == 1'b1) rNxtState <= ST_ROW0;
			else rNxtState <= ST_IDLE;
		end
		ST_ROW0: begin
			if(wCol_end) rNxtState <= ST_ROW_ODD;
			else rNxtState <= ST_ROW0;
		end
		ST_ROW_ODD: begin
			if(wCol_end) rNxtState <= ST_ROW_EVEN;
			else rNxtState <= ST_ROW_ODD;
		end
		ST_ROW_EVEN: begin
			if(wCol_end && wRow_end) 
				rNxtState <= ST_ROW_END;
			else if(wCol_end)
				rNxtState <= ST_ROW_ODD;
			else
				rNxtState <= ST_ROW_EVEN;
		end
		ST_ROW_END: begin
			if(wCol_end) rNxtState <= ST_IDLE;
			else rNxtState <= ST_ROW_END;
		end
		default :
			rNxtState <= ST_IDLE;
    endcase            
end

////////////////
/* adressing signal1 chip select lsb = 0bram msb = 15bram*/ 
//////////////
always @(*) begin
	case(rCurState)
	ST_ROW0: begin
		if(rCol == 0) wCs = 16'b0000_0111_0111_0111;
		else wCs = 16'h0fff; 
	end
	ST_ROW_ODD: begin
		if(rCol == 0) wCs = 16'b0111_0111_0111_0111;
		else wCs = 16'hffff; 
	end
	ST_ROW_EVEN: begin
		if(rCol == 0) wCs = 16'b0111_0111_0111_0111;
		else wCs = 16'hffff; 
	end
	ST_ROW_END: begin
		if(rCol == 0) wCs = 16'b0111_0111_0111_0000;
		else wCs = 16'hfff0; 
	end
	endcase  
end


integer i;
////////////////
// adressing signal2 adress declare
//////////////
always @(posedge clk, negedge rstn) begin
	if(!rstn) begin
		for(i=0;i<16;i=i+1) begin
			rAddr[i] <= 9'b0;
		end
		rRow_toggle1 <= 1'b0;
		rRow_toggle2 <= 1'b0;
	end
	else begin
		case(rCurState)
		
			ST_ROW0: begin
				if(wCol_end) begin
					for(i=4;i<16;i=i+1) begin
						rAddr[i] <= 9'd0;
					end
					for(i=0;i<4;i=i+1) begin
						rAddr[i] <= 9'd64;
					end
				end
			end
			ST_ROW_ODD: begin
				if(wCol_end) begin

					if(rRow_toggle1) begin
						for(i=0;i<12;i=i+1) begin
							rAddr[i] <= 9'd0;
						end
						for(i=12;i<16;i=i+1) begin
							rAddr[i] <= 9'd64;
						end
					end
					else begin
						for(i=0;i<12;i=i+1) begin
							rAddr[i] <= 9'd64;
						end
						for(i=12;i<16;i=i+1) begin
							rAddr[i] <= 9'd0;
						end
					end

					rRow_toggle1 <= rRow_toggle1 + 1'b1;
				end
			end
			ST_ROW_EVEN: begin
				if(wCol_end) begin

					if(rRow_toggle2) begin
						for(i=4;i<16;i=i+1) begin
							rAddr[i] <= 9'd0;
						end
						for(i=0;i<4;i=i+1) begin
							rAddr[i] <= 9'd64;
						end
					end
					else begin
						for(i=4;i<16;i=i+1) begin
							rAddr[i] <= 9'd64;
						end
						for(i=0;i<4;i=i+1) begin
							rAddr[i] <= 9'd0;
						end
					end

					rRow_toggle2 <= rRow_toggle2 + 1'b1;
				end
			end
				
    	endcase 
	end 
end

//Col row value calculate
always@(posedge clk, negedge rstn) begin
    if(!rstn) begin
       rCol<= 8'b0;
	   rRow <= 8'b0;
	   rCnt_delay <= 0;
	   rCol_toggle <= 0;
    end
    else if(i_run && (rCurState != ST_IDLE)) begin
        if(rCnt_delay == windowDelay)begin
			rCnt_delay <= 0;
			rCol <=  rCol + 1;
			rCol_toggle <= rCol_toggle + 1'b1;//toggle 1bit continuouly adding one 

			if(rCol_toggle) begin
				rAddr[0] <= rAddr[0] + 1;
				rAddr[1] <= rAddr[1] + 1;
				rAddr[4] <= rAddr[4] + 1;
				rAddr[5] <= rAddr[5] + 1;
				rAddr[8] <= rAddr[8] + 1;
				rAddr[9] <= rAddr[9] + 1;
				rAddr[12] <= rAddr[12] + 1;
				rAddr[13] <= rAddr[13] + 1;
			end
			else begin
				rAddr[2] <= rAddr[2] + 1;
				rAddr[3] <= rAddr[3] + 1;
				rAddr[6] <= rAddr[6] + 1;
				rAddr[7] <= rAddr[7] + 1;
				rAddr[10] <= rAddr[10] + 1;
				rAddr[11] <= rAddr[11] + 1;
				rAddr[14] <= rAddr[14] + 1;
				rAddr[15] <= rAddr[15] + 1;
			end

		end
		else begin
			rCnt_delay <= rCnt_delay + 1'b1;
		end

		if(wCol_end) begin
			rCol <= 0;
			rRow <= rRow + 1'b1;
		end
    end
end

assign wCol_end = (rCol == MAXCOL) ? 1'b1 : 1'b0;
assign wRow_end = (rRow == MAXROW) ? 1'b1 : 1'b0;


//////////////////////////////
// ZERO PADDING
//////////////////////////////
always @(posedge clk, negedge rstn) begin //name
	if(!rstn) begin
		rSplit_cnt <= 0;
		for(i=0;i<16;i=i+1) begin
			r_data[i] <= 0;
			r_din[i] <= 0;
		end
	end
	else begin
		
		r_data[0] <= iData0;
		r_data[1] <= iData1;
		r_data[2] <= iData2;
		r_data[3] <= iData3;
		r_data[4] <= iData4;
		r_data[5] <= iData5;
		r_data[6] <= iData6;
		r_data[7] <= iData7;
		r_data[8] <= iData8;
		r_data[9] <= iData9;
		r_data[10] <= iData10;
		r_data[11] <= iData11;
		r_data[12] <= iData12;
		r_data[13] <= iData13;
		r_data[14] <= iData14;
		r_data[15] <= iData15;	

		if(rCnt_delay != 0) begin
			case(rCurState)
				ST_ROW0: begin
					if(rCol == 0) begin //if col is 0
						for(i=0;i<4;i=i+1) begin
							r_din[i] <= 8'h0;
						end
						for(i=4;i<13;i=i+4) begin
							r_din[i] <= 8'h0;
						end
						if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
							r_din[5] <= r_data[0][rSplit_cnt+:8];
							r_din[6] <= r_data[1][rSplit_cnt+:8];
							r_din[7] <= r_data[2][rSplit_cnt+:8];
							r_din[9] <= r_data[4][rSplit_cnt+:8];
							r_din[10] <= r_data[5][rSplit_cnt+:8];
							r_din[11] <= r_data[6][rSplit_cnt+:8];
							r_din[13] <= r_data[8][rSplit_cnt+:8];
							r_din[14] <= r_data[9][rSplit_cnt+:8];
							r_din[15] <= r_data[10][rSplit_cnt+:8];
							rSplit_cnt <= rSplit_cnt + 8;
						end
						else rSplit_cnt <= 0;
					end
					else begin //if col is not 0
						for(i=0;i<4;i=i+1) begin
							r_din[i] <= 8'h0;
						end
						if(rCnt_delay != 0) begin
							if(rCol_toggle) begin
								if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
									r_din[4] <= r_data[1][rSplit_cnt+:8];
									r_din[5] <= r_data[2][rSplit_cnt+:8];
									r_din[6] <= r_data[3][rSplit_cnt+:8];
									r_din[7] <= r_data[0][rSplit_cnt+:8];

									r_din[8] <= r_data[5][rSplit_cnt+:8];
									r_din[9] <= r_data[6][rSplit_cnt+:8];
									r_din[10] <= r_data[7][rSplit_cnt+:8];
									r_din[11] <= r_data[4][rSplit_cnt+:8];

									r_din[12] <= r_data[9][rSplit_cnt+:8];
									r_din[13] <= r_data[10][rSplit_cnt+:8];
									r_din[14] <= r_data[11][rSplit_cnt+:8];
									r_din[15] <= r_data[8][rSplit_cnt+:8];

									rSplit_cnt <= rSplit_cnt + 8;
								end
								else rSplit_cnt <= 0;
							end
							else begin
								if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
									r_din[4] <= r_data[3][rSplit_cnt+:8];
									r_din[5] <= r_data[0][rSplit_cnt+:8];
									r_din[6] <= r_data[1][rSplit_cnt+:8];
									r_din[7] <= r_data[2][rSplit_cnt+:8];

									r_din[8] <= r_data[7][rSplit_cnt+:8];
									r_din[9] <= r_data[4][rSplit_cnt+:8];
									r_din[10] <= r_data[5][rSplit_cnt+:8];
									r_din[11] <= r_data[6][rSplit_cnt+:8];

									r_din[12] <= r_data[11][rSplit_cnt+:8];
									r_din[13] <= r_data[8][rSplit_cnt+:8];
									r_din[14] <= r_data[9][rSplit_cnt+:8];
									r_din[15] <= r_data[10][rSplit_cnt+:8];

									rSplit_cnt <= rSplit_cnt + 8;
								end
								else rSplit_cnt <= 0;
							end
						end
					end
				end
				ST_ROW_ODD: begin
					if(rCol == 0) begin //if col is 0
						if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
							r_din[0] <= 8'b0;
							r_din[1] <= r_data[4][rSplit_cnt+:8];
							r_din[2] <= r_data[5][rSplit_cnt+:8];
							r_din[3] <= r_data[6][rSplit_cnt+:8];

							r_din[4] <= 8'b0;
							r_din[5] <= r_data[8][rSplit_cnt+:8];
							r_din[6] <= r_data[9][rSplit_cnt+:8];
							r_din[7] <= r_data[10][rSplit_cnt+:8];

							r_din[8] <= 8'b0;
							r_din[9] <= r_data[12][rSplit_cnt+:8];
							r_din[10] <= r_data[13][rSplit_cnt+:8];
							r_din[11] <= r_data[14][rSplit_cnt+:8];

							r_din[12] <= 8'b0;
							r_din[13] <= r_data[0][rSplit_cnt+:8];
							r_din[14] <= r_data[1][rSplit_cnt+:8];
							r_din[15] <= r_data[2][rSplit_cnt+:8];

							rSplit_cnt <= rSplit_cnt + 8;
						end
						else rSplit_cnt <= 0;
					end
					else begin //if col is not 0
						if(rCol_toggle) begin
							if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
								r_din[0] <= r_data[5][rSplit_cnt+:8];
								r_din[1] <= r_data[6][rSplit_cnt+:8];
								r_din[2] <= r_data[7][rSplit_cnt+:8];
								r_din[3] <= r_data[4][rSplit_cnt+:8];
	
								r_din[4] <= r_data[9][rSplit_cnt+:8];
								r_din[5] <= r_data[10][rSplit_cnt+:8];
								r_din[6] <= r_data[11][rSplit_cnt+:8];
								r_din[7] <= r_data[8][rSplit_cnt+:8];
	
								r_din[8] <= r_data[13][rSplit_cnt+:8];
								r_din[9] <= r_data[14][rSplit_cnt+:8];
								r_din[10] <= r_data[15][rSplit_cnt+:8];
								r_din[11] <= r_data[12][rSplit_cnt+:8];
	
								r_din[12] <= r_data[1][rSplit_cnt+:8];
								r_din[13] <= r_data[2][rSplit_cnt+:8];
								r_din[14] <= r_data[3][rSplit_cnt+:8];
								r_din[15] <= r_data[0][rSplit_cnt+:8];
	
								rSplit_cnt <= rSplit_cnt + 8;
							end
							else rSplit_cnt <= 0;
						end
						else begin
							if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
								r_din[0] <= r_data[7][rSplit_cnt+:8];
								r_din[1] <= r_data[4][rSplit_cnt+:8];
								r_din[2] <= r_data[5][rSplit_cnt+:8];
								r_din[3] <= r_data[6][rSplit_cnt+:8];
	
								r_din[4] <= r_data[11][rSplit_cnt+:8];
								r_din[5] <= r_data[8][rSplit_cnt+:8];
								r_din[6] <= r_data[9][rSplit_cnt+:8];
								r_din[7] <= r_data[10][rSplit_cnt+:8];
	
								r_din[8] <= r_data[15][rSplit_cnt+:8];
								r_din[9] <= r_data[12][rSplit_cnt+:8];
								r_din[10] <= r_data[13][rSplit_cnt+:8];
								r_din[11] <= r_data[14][rSplit_cnt+:8];
	
								r_din[12] <= r_data[3][rSplit_cnt+:8];
								r_din[13] <= r_data[0][rSplit_cnt+:8];
								r_din[14] <= r_data[1][rSplit_cnt+:8];
								r_din[15] <= r_data[2][rSplit_cnt+:8];
	
								rSplit_cnt <= rSplit_cnt + 8;
							end
							else rSplit_cnt <= 0;
						end
					end
				end
				ST_ROW_EVEN: begin
					if(rCol == 0) begin //if col is 0
						if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
							r_din[0] <= 8'b0;
							r_din[1] <= r_data[12][rSplit_cnt+:8];
							r_din[2] <= r_data[13][rSplit_cnt+:8];
							r_din[3] <= r_data[14][rSplit_cnt+:8];

							r_din[4] <= 8'b0;
							r_din[5] <= r_data[0][rSplit_cnt+:8];
							r_din[6] <= r_data[1][rSplit_cnt+:8];
							r_din[7] <= r_data[2][rSplit_cnt+:8];

							r_din[8] <= 8'b0;
							r_din[9] <= r_data[4][rSplit_cnt+:8];
							r_din[10] <= r_data[5][rSplit_cnt+:8];
							r_din[11] <= r_data[6][rSplit_cnt+:8];

							r_din[12] <= 8'b0;
							r_din[13] <= r_data[8][rSplit_cnt+:8];
							r_din[14] <= r_data[9][rSplit_cnt+:8];
							r_din[15] <= r_data[10][rSplit_cnt+:8];

							rSplit_cnt <= rSplit_cnt + 8;
						end
						else rSplit_cnt <= 0;
					end
					else begin //if col is not 0
						if(rCol_toggle) begin
							if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
								r_din[0] <= r_data[13][rSplit_cnt+:8];
								r_din[1] <= r_data[14][rSplit_cnt+:8];
								r_din[2] <= r_data[15][rSplit_cnt+:8];
								r_din[3] <= r_data[12][rSplit_cnt+:8];
	
								r_din[4] <= r_data[1][rSplit_cnt+:8];
								r_din[5] <= r_data[2][rSplit_cnt+:8];
								r_din[6] <= r_data[3][rSplit_cnt+:8];
								r_din[7] <= r_data[0][rSplit_cnt+:8];
	
								r_din[8] <= r_data[5][rSplit_cnt+:8];
								r_din[9] <= r_data[6][rSplit_cnt+:8];
								r_din[10] <= r_data[7][rSplit_cnt+:8];
								r_din[11] <= r_data[4][rSplit_cnt+:8];
	
								r_din[12] <= r_data[9][rSplit_cnt+:8];
								r_din[13] <= r_data[10][rSplit_cnt+:8];
								r_din[14] <= r_data[11][rSplit_cnt+:8];
								r_din[15] <= r_data[8][rSplit_cnt+:8];
	
								rSplit_cnt <= rSplit_cnt + 8;
							end
							else rSplit_cnt <= 0;
						end
						else begin
							if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
								r_din[0] <= r_data[7][rSplit_cnt+:8];
								r_din[1] <= r_data[4][rSplit_cnt+:8];
								r_din[2] <= r_data[5][rSplit_cnt+:8];
								r_din[3] <= r_data[6][rSplit_cnt+:8];
	
								r_din[4] <= r_data[11][rSplit_cnt+:8];
								r_din[5] <= r_data[8][rSplit_cnt+:8];
								r_din[6] <= r_data[9][rSplit_cnt+:8];
								r_din[7] <= r_data[10][rSplit_cnt+:8];
	
								r_din[8] <= r_data[15][rSplit_cnt+:8];
								r_din[9] <= r_data[12][rSplit_cnt+:8];
								r_din[10] <= r_data[13][rSplit_cnt+:8];
								r_din[11] <= r_data[14][rSplit_cnt+:8];
	
								r_din[12] <= r_data[3][rSplit_cnt+:8];
								r_din[13] <= r_data[0][rSplit_cnt+:8];
								r_din[14] <= r_data[1][rSplit_cnt+:8];
								r_din[15] <= r_data[2][rSplit_cnt+:8];
	
								rSplit_cnt <= rSplit_cnt + 8;
							end
							else rSplit_cnt <= 0;
						end
					end
				end
				ST_ROW_END: begin
					if(rCol == 0) begin //if col is 0
						for(i=12;i<16;i=i+1) begin
							r_din[i] <= 8'h0;
						end
						for(i=0;i<9;i=i+4) begin//0 4 8
							r_din[i] <= 8'h0;
						end
						if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
							r_din[1] <= r_data[4][rSplit_cnt+:8];
							r_din[2] <= r_data[5][rSplit_cnt+:8];
							r_din[3] <= r_data[6][rSplit_cnt+:8];

							r_din[5] <= r_data[8][rSplit_cnt+:8];
							r_din[6] <= r_data[9][rSplit_cnt+:8];
							r_din[7] <= r_data[10][rSplit_cnt+:8];

							r_din[10] <= r_data[12][rSplit_cnt+:8];
							r_din[11] <= r_data[13][rSplit_cnt+:8];
							r_din[12] <= r_data[14][rSplit_cnt+:8];

							rSplit_cnt <= rSplit_cnt + 8;
						end
						else rSplit_cnt <= 0;
					end
					else begin //if col is not 0
						for(i=12;i<16;i=i+1) begin
							r_din[i] <= 8'h0;
						end
						if(rCnt_delay != 0) begin
							if(rCol_toggle) begin
								if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
									r_din[0] <= r_data[5][rSplit_cnt+:8];
									r_din[1] <= r_data[6][rSplit_cnt+:8];
									r_din[2] <= r_data[7][rSplit_cnt+:8];
									r_din[3] <= r_data[4][rSplit_cnt+:8];

									r_din[4] <= r_data[9][rSplit_cnt+:8];
									r_din[5] <= r_data[10][rSplit_cnt+:8];
									r_din[6] <= r_data[11][rSplit_cnt+:8];
									r_din[7] <= r_data[8][rSplit_cnt+:8];

									r_din[8] <= r_data[13][rSplit_cnt+:8];
									r_din[9] <= r_data[14][rSplit_cnt+:8];
									r_din[10] <= r_data[15][rSplit_cnt+:8];
									r_din[11] <= r_data[12][rSplit_cnt+:8];

									rSplit_cnt <= rSplit_cnt + 8;
								end
								else rSplit_cnt <= 0;
							end
							else begin
								if(rSplit_cnt < ACC_CNT) begin // 4ea rgb0 slicing 
									r_din[0] <= r_data[4][rSplit_cnt+:8];
									r_din[1] <= r_data[5][rSplit_cnt+:8];
									r_din[2] <= r_data[6][rSplit_cnt+:8];
									r_din[3] <= r_data[7][rSplit_cnt+:8];

									r_din[4] <= r_data[8][rSplit_cnt+:8];
									r_din[5] <= r_data[9][rSplit_cnt+:8];
									r_din[6] <= r_data[10][rSplit_cnt+:8];
									r_din[7] <= r_data[11][rSplit_cnt+:8];

									r_din[8] <= r_data[12][rSplit_cnt+:8];
									r_din[9] <= r_data[13][rSplit_cnt+:8];
									r_din[10] <= r_data[14][rSplit_cnt+:8];
									r_din[11] <= r_data[15][rSplit_cnt+:8];

									rSplit_cnt <= rSplit_cnt + 8;
								end
								else rSplit_cnt <= 0;
							end
						end
					end
				end
			endcase
		end
	end
end

assign oCs = wCs;

assign oAddr0 = rAddr[0];
assign oAddr1 = rAddr[1];
assign oAddr2 = rAddr[2];
assign oAddr3 = rAddr[3];
assign oAddr4 = rAddr[4];
assign oAddr5 = rAddr[5];
assign oAddr6 = rAddr[6];
assign oAddr7 = rAddr[7];
assign oAddr8 = rAddr[8];
assign oAddr9 = rAddr[9];
assign oAddr10 = rAddr[10];
assign oAddr11 = rAddr[11];
assign oAddr12 = rAddr[12];
assign oAddr13 = rAddr[13];
assign oAddr14 = rAddr[14];
assign oAddr15 = rAddr[15];

assign oDin0 = r_din[0];
assign oDin1 = r_din[1];
assign oDin2 = r_din[2];
assign oDin3 = r_din[3];
assign oDin4 = r_din[4];
assign oDin5 = r_din[5];
assign oDin6 = r_din[6];
assign oDin7 = r_din[7];
assign oDin8 = r_din[8];
assign oDin9 = r_din[9];
assign oDin10 = r_din[10];
assign oDin11 = r_din[11];
assign oDin12 = r_din[12];
assign oDin13 = r_din[13];
assign oDin14 = r_din[14];
assign oDin15 = r_din[15];
	
endmodule