`timescale 1ns/10ps

module digtop_tb;

reg xtal_clk;
reg por_rst_n;

wire scl;
wire sda;
wire hif_idle_wire;

reg scan_en;
reg sdx_input;
reg scl_input;

digtop digtop_i (
.xtal_clk (xtal_clk), 	
.por_rst_n (por_rst_n),		
.hif_scl (scl),
.hif_scl_del (scl_input),
.hif_sda_del (scl_input),
.slow_clk_in (slow_clk_in),
.sdx_input (sdx_input),
.hif_idle_feedback (hif_idle_wire),
.i2c_clk_after_del (scl_input),
.i2c_din_after_del (sda),
.i2c_din_before_del (sda),
.i2c_dout_after_del (sda_o),
.i2c_dout_before_del (sda_o),
.i_otp_q (i_otp_q),
.scan_en (scan_en),
.scan_clk (scan_clk)
);

initial begin
  scan_en = 1'b0;
  sdx_input = 1'b1;
  scl_input = 1'b1;
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
