`timescale 1ns/10ps
module efuse_model (
	CSB,
	STROBE,
	LOAD,
	Q,
	VDDQ,
	A,
	PGENB,
	VDD,
	VSS
);

input CSB;
input STROBE;
input LOAD;
output [7:0] Q;
input VDDQ;
input [9:0] A;
input PGENB;

wire CSB_clk_n;

// determine operation mode
always @(*)
  begin
    if ((CSB == 1'b0) && (VDDQ == 1'b1) && (PGENB == 1'b0) && (LOAD == 1'b0)) begin
	  PGM_MODE = 1'b1;
	  READ_MODE = 1'b0;
	else if ((CSB == 1'b0) && (VDDQ == 1'b0) && (PGENB == 1'b1) && (LOAD == 1'b1)) begin
	  PGM_MODE = 1'b0;
	  READ_MODE = 1'b1;
	else 
	  PGM_MODE = 1'b0;
	  READ_MODE = 1'b0;
  end

assign rst_mode = PGM_MODE | READ_MODE;

// implement fsm for otp memory
// model TEF65GP128x8HD
always @(posedge STROBE or negedge rst_mode)
  begin
    if (rst_mode == 1'b0)
	  
    if (
	else 
	  if (
		
  end