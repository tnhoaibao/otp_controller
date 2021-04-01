`timescale 1ns/10ps

module top_tb;

reg sys_clk;
reg rst_n;

reg [7:0] xbus_dout;
reg i_otp_prog;
reg i_otp_read_n;
reg i_run_test_mode;

reg [7:0] i_otp_q;

reg i2c_sda_clk;
reg i2c_sda_n_clk;
reg i2c_scl;
reg slow_clk;
reg i2c_stop_rst_n;
reg i2c_scl_rst_n;
reg i2c_rst_n;
reg i2c_wd_en_n;
reg i2c_wd_sel;

reg scan_en;
reg scan_clk;
reg i2c_scl_clk;
reg i2c_scl_n_clk;
reg i2c_active_rst_n;
reg i2c_sda_i;

reg [6:0] m_i2c_addr;
reg i2c_addr_inv;

wire [7:0] xbus_din;
wire [6:0] xbus_addr;
wire xbus_wr;

wire o_otp_vddqsw;
wire o_otp_csb;
wire o_otp_strobe;
wire o_otp_load;
wire [9:0] o_otp_addr;
wire o_otp_pgenb;

wire i2c_active;
wire i2c_start;
wire i2c_stop;
wire i2c_wd_rst;
wire i2c_sda_o;
wire hif_idle;


memtop memtop_i (
.sys_clk (sys_clk), 	
.rst_n (rst_n),		
//sent/received to/from register file
.xbus_addr (xbus_addr),	
.xbus_din (xbus_din),	
.xbus_dout (xbus_dout),	
.xbus_wr (xbus_wr),	
.i_run_test_mode (i_run_test_mode),
.i_otp_read_n (i_otp_read_n),	
.i_otp_prog (i_otp_prog),		
.reg_file_clk (reg_file_clk),	
//sent/received to/from otp memory
.o_otp_vddqsw (o_otp_vddqsw),	
.o_otp_csb (o_otp_csb),		
.o_otp_strobe (o_otp_strobe),	
.o_otp_load (o_otp_load),		
.i_otp_q (i_otp_q),		
.o_otp_addr (o_otp_addr),		
.o_otp_pgenb (o_otp_pgenb),	
//for dft implement
.scan_en (scan_en),		
.scan_clk (scan_clk),		
//sent/received to/from i2c interface or correspoding module
.i2c_sda_clk (i2c_sda_clk),	
.i2c_sda_n_clk (i2c_sda_n_clk),	
.i2c_scl (i2c_scl),		
.slow_clk (slow_clk),		
.i2c_stop_rst_n (i2c_stop_rst_n),	
.i2c_scl_rst_n (i2c_scl_rst_n),	
.i2c_rst_n (i2c_rst_n),		
.i2c_wd_en_n (i2c_wd_en_n),	
.i2c_wd_sel (i2c_wd_sel),		
.i2c_active (i2c_active),		
.i2c_start (i2c_start),		
.i2c_stop (i2c_stop),		
.i2c_wd_rst (i2c_wd_rst),		
.i2c_scl_clk (i2c_scl_clk),	
.i2c_scl_n_clk (i2c_scl_n_clk),	
.i2c_active_rst_n (i2c_active_rst_n),
.i2c_sda_i (i2c_sda_i),		
.i2c_sda_o (i2c_sda_o),		
.m_i2c_addr (m_i2c_addr),		
.i2c_addr_inv (i2c_addr_inv),	
.hif_idle (hif_idle)		
);
// clock definition
always begin
  sys_clk = 1'b1;
  #5;
  sys_clk = 1'b0;
  #5;
end

// reset
initial begin
  rst_n = 1'b0;
  #10;
  rst_n = 1'b1;
end

// i_run_test_mode
initial begin
  i_run_test_mode = 1'b1;
  #50;
  i_run_test_mode = 1'b1;
end

// i_otp_prog
always @(posedge sys_clk)
  begin
    if (rst_n == 1'b0)
	  i_otp_prog <= 1'b1;
    else if ((xbus_addr == 7'd99) && (xbus_din == 8'hFF)) 
      i_otp_prog <= 1'b0;
    else
      i_otp_prog <= i_otp_prog;
  end

// PGM (no reading) operation
initial begin
  i_otp_read_n = 1'b1;
  scan_en = 1'b0;
  scan_clk = 1'b0;
  i2c_sda_clk = 1'b1;
  i2c_sda_n_clk = 1'b0;
  i2c_scl = 1'b1;
  slow_clk = 1'b0;
  i2c_stop_rst_n = 1'b1;
  i2c_scl_rst_n = 1'b1;
  i2c_rst_n = 1'b1;
  i2c_wd_en_n = 1'b1;
  i2c_wd_sel = 1'b1;
  i2c_scl_clk = 1'b1;
  i2c_scl_n_clk = 1'b0;
  i2c_active_rst_n = 1'b1;
  i2c_sda_i = 1'b1;
  m_i2c_addr = 7'h0A;
  i2c_addr_inv = 1'b1;
end

// data from register file
always begin
  i_otp_q = $random;
  #12;
  i_otp_q = $random;
  #12;
end

always begin
  xbus_dout = 8'hAA;
  #12;
  xbus_dout = 8'hAA;
  #12;
end
endmodule
