`timescale 1ns/10ps

module efuse_tb;

reg sys_clk;
reg rst_n;

reg i_i2c_busy;
reg i_run_test_mode;

wire o_otp_vddqsw;
wire o_otp_csb;
wire o_otp_strobe;
wire o_otp_load;
reg [7:0] i_otp_q;
wire o_otp_addr;
wire o_otp_pgenb;

wire [7:0] o_xbus_din;
wire [6:0] o_xbus_addr;
reg [7:0] i_xbus_dout;
reg i_otp_read_n;
reg i_otp_prog;

otp_main efuse_main_i (
.sys_clk	(sys_clk),
.rst_n		(rst_n),
.i_i2c_busy	(i_i2c_busy),	
.i_run_test_mode(i_run_test_mode),	
/* connect to efuse */
.o_otp_vddqsw	(o_otp_vddqsw),	
.o_otp_csb	(o_otp_csb),	
.o_otp_strobe	(o_otp_strobe),	
.o_otp_load	(o_otp_load),	
.i_otp_q	(i_otp_q),	
.o_otp_addr	(o_otp_addr),	
.o_otp_pgenb	(o_otp_pgenb),	
/* connect to reg file */
.o_xbus_din	(o_xbus_din),	
.o_xbus_addr	(o_xbus_addr),	
.i_xbus_dout	(i_xbus_dout),	
.i_otp_read_n	(i_otp_read_n), 
.i_otp_prog	(i_otp_prog)
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

// i_i2c_busy
initial begin
  i_i2c_busy = 1'b1;
  #25;
  i_i2c_busy = 1'b0;
end

// i_run_test_mode
initial begin
  i_run_test_mode = 1'b1;
  #50;
  i_run_test_mode = 1'b1;
end

// PGM (no reading) operation
initial begin
  i_otp_read_n = 1'b1;
  #40;
  i_otp_read_n = 1'b1;
end

initial begin
  i_otp_prog = 1'b0;
  #40;
  i_otp_prog = 1'b1;
end

// data from register file
always begin
  #40;
  i_xbus_dout = 8'h66;
  #80;
  i_xbus_dout = 8'h66;
  #40;
end

// data from register file
always begin
  i_otp_q = $random;
  #12;
  i_otp_q = $random;
  #12;
end
endmodule