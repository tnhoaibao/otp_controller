`timescale 1ns/10ps

module digtop_tb;

reg xtal_clk;
reg por_rst_n;

wire sda;
wire hif_idle_wire;

reg scan_en;
reg scan_clk;
wire sdx_input;
wire scl_input;

wire o_otp_vddqsw;
wire o_otp_csb;
wire o_otp_strobe;
wire o_otp_load;
wire [7:0] i_otp_q;
wire [9:0] o_otp_addr;
wire o_otp_pgenb;
reg clk_scl_1;
reg clk_sda_1;
reg i2c_reset_n_1;
reg clk_scl_2;
reg clk_sda_2;
reg i2c_reset_n_2;
wire sdx_input_1;
wire sdx_input_2;
wire scl_input_1;
wire scl_input_2;

i2c_master_1 i2c_master_1 (
.clk_scl (clk_scl_1),
.clk_sda (clk_sda_1),
.rst_n   (i2c_reset_n_1),
.i2c_sda (sdx_input_1),
.i2c_scl (scl_input_1)
);

i2c_master_passcode i2c_master_2 (
.clk_scl (clk_scl_2),
.clk_sda (clk_sda_2),
.rst_n   (i2c_reset_n_2),
.i2c_sda (sdx_input_2),
.i2c_scl (scl_input_2)
);

digtop digtop_i (
.xtal_clk (xtal_clk), 	
.por_rst_n (por_rst_n),		
.hif_scl (scl_input),
.hif_scl_del (scl_input),
.hif_sda_del (sda),
.slow_clk_in (slow_clk_in),
.sdx_input (sdx_input),
.hif_idle_feedback (hif_idle_wire),
.i2c_clk_after_del (scl_input),
.i2c_din_after_del (sda),
.i2c_din_before_del (sda),
.i2c_dout_after_del (sda_o),
.i2c_dout_before_del (sda_o),
.scan_en (scan_en),
.scan_clk (scan_clk),
.o_otp_vddqsw (o_otp_vddqsw ),		
.o_otp_csb (o_otp_csb),		
.o_otp_strobe (o_otp_strobe),		
.o_otp_load (o_otp_load),			
.i_otp_q (i_otp_q),			
.o_otp_addr (o_otp_addr),		
.o_otp_pgenb (o_otp_pgenb),
.hif_idle_out (hif_idle_wire)
);

efuse_model efuse_model_i (
.VDDQ (o_otp_vddqsw ),		
.CSB (o_otp_csb),		
.STROBE (o_otp_strobe),		
.LOAD (o_otp_load),			
.Q (i_otp_q),			
.A (o_otp_addr),		
.PGENB (o_otp_pgenb)
);

assign sdx_input = (i2c_reset_n_2 == 1) ? sdx_input_2 : sdx_input_1;
assign scl_input = (i2c_reset_n_2 == 1) ? scl_input_2 : scl_input_1;

//setup i2c transfer i2c master_1 --> usb chip
always begin
  clk_scl_1 = 1'b1;
  #20;
  clk_scl_1 = 1'b0;
  #20;
end

always begin
  clk_sda_1 = 1'b0;
  #5;
  clk_sda_1 = 1'b1;
  #20;
  clk_sda_1 = 1'b0;
  #15;
end

initial begin
  i2c_reset_n_1 = 1'b0;
  #16000;
  i2c_reset_n_1 = 1'b1;
end

//setup i2c transfer i2c master_2 --> usb chip
always begin
  clk_scl_2 = 1'b1;
  #20;
  clk_scl_2 = 1'b0;
  #20;
end

always begin
  clk_sda_2 = 1'b0;
  #5;
  clk_sda_2 = 1'b1;
  #20;
  clk_sda_2 = 1'b0;
  #15;
end

initial begin
  i2c_reset_n_2 = 1'b0;
  #30000;
  i2c_reset_n_2 = 1'b1;
end


initial begin
  scan_en = 1'b0;
//  sdx_input = 1'b1;
//  scl_input = 1'b1;
  scan_clk = 1'b0;
end

// clock definition
always begin
  xtal_clk = 1'b1;
  #5;
  xtal_clk = 1'b0;
  #5;
end

// reset
initial begin
  por_rst_n = 1'b0;
  #10;
  por_rst_n = 1'b1;
end

endmodule
