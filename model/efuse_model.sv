`timescale 1ns/10ps
module efuse_model (
	CSB,
	STROBE,
	LOAD,
	Q,
	VDDQ,
	A,
	PGENB
);

input CSB;
input STROBE;
input LOAD;
output [7:0] Q;
input VDDQ;
input [9:0] A;
input PGENB;

wire CSB_clk_n;

reg [7:0] efuse_00;
reg [7:0] efuse_01;
reg [7:0] efuse_02;
reg [7:0] efuse_03;
reg [7:0] efuse_04;
reg [7:0] efuse_05;
reg [7:0] efuse_06;
reg [7:0] efuse_07;
reg [7:0] efuse_08;
reg [7:0] efuse_09;

reg [7:0] Q;
reg PGM_MODE;
reg READ_MODE;
wire rst_mode;
wire [2:0] bit_order;
wire STROBE_n;

// determine operation mode
always @(*)
  begin
    if ((CSB == 1'b0) && (VDDQ == 1'b1) && (PGENB == 1'b0) && (LOAD == 1'b0)) begin
	  PGM_MODE = 1'b1;
	  READ_MODE = 1'b0;
	end else if ((CSB == 1'b0) && (VDDQ == 1'b0) && (PGENB == 1'b1) && (LOAD == 1'b1)) begin
	  PGM_MODE = 1'b0;
	  READ_MODE = 1'b1;
	end else begin
	  PGM_MODE = 1'b0;
	  READ_MODE = 1'b0;
    end
  end

assign rst_mode = PGM_MODE | READ_MODE;
assign bit_order = A[9:7];
assign STROBE_n = ~STROBE;

// determine boot phase value
initial begin
  efuse_00 = 8'h00;
  efuse_01 = 8'hFF;
  efuse_02 = 8'h00;
  efuse_03 = 8'hFF;
  efuse_04 = 8'h00;
  efuse_05 = 8'hFF;
  efuse_06 = 8'hFF;
  efuse_07 = 8'h00;
  efuse_08 = 8'hFF;
  efuse_09 = 8'h00;
end

// implement pgm operation
// model TEF65GP128x8HD
always @(posedge STROBE)
  begin
	if (PGM_MODE == 1'b1) 
	  case (A[6:0])
	    7'd0: efuse_00[bit_order] <= 1'b1;
		7'd1: efuse_01[bit_order] <= 1'b1;
		7'd2: efuse_02[bit_order] <= 1'b1;
		7'd3: efuse_03[bit_order] <= 1'b1;
		7'd4: efuse_04[bit_order] <= 1'b1;
		7'd5: efuse_05[bit_order] <= 1'b1;
		7'd6: efuse_06[bit_order] <= 1'b1;
		7'd7: efuse_07[bit_order] <= 1'b1;
		7'd8: efuse_08[bit_order] <= 1'b1;
		7'd9: efuse_09[bit_order] <= 1'b1;
	  endcase
  end
  
// implement read operation
// model TEF65GP128x8HD
always @(posedge STROBE)
  begin
    if (READ_MODE == 1'b1) begin
	  case (A[6:0])
	  	7'd0: Q <= efuse_00;
		7'd1: Q <= efuse_01;
		7'd2: Q <= efuse_02;
		7'd3: Q <= efuse_03;
		7'd4: Q <= efuse_04;
		7'd5: Q <= efuse_05;
		7'd6: Q <= efuse_06;
		7'd7: Q <= efuse_07;
		7'd8: Q <= efuse_08;
		7'd9: Q <= efuse_09;
	  endcase
	end else Q <= $random;
	 
  end
  
endmodule