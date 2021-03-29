`timescale 1ns/10ps

module apb_mux (
	i2c_busy,		//input signal indicates that there is i2c transaction or not, 1-i2c transaction, 0-no i2c transaction
	otp_busy,		//input signal indicates that there is otp prg/read transaction or not, 1-otp transaction, 0-no otp transaction
	i2c_xbus_addr,	//i2c address bus to access reg file
	i2c_xbus_wr,	//i2c read/write enable to access reg file, 1-write, 0-read
	i2c_xbus_din,	//i2c input data bus to access to reg file
	i2c_xbus_dout,	//i2c output data bus from reg file
	otp_xbus_addr,	//otp address bus to access reg file
	otp_xbus_wr,	//otp read/write enable to access reg file, 1-write, 0-read
	otp_xbus_din,	//otp input data bus to access to reg file
	otp_xbus_dout,	//otp output data bus from reg file
	xbus_addr,		//address bus to access reg file
	xbus_wr,		//read/write enable to access reg file
	xbus_dout,		//data bus to access reg file
	xbus_din,		//data bus from reg file
	sys_clk,		//system clock, 200MHz clock generated by LO
	rst_n);			//power on reset, active low

input otp_busy;
input i2c_busy;

input [6:0] i2c_xbus_addr;
input i2c_xbus_wr;
input [7:0] i2c_xbus_din;
output [7:0] i2c_xbus_dout;

input [6:0] otp_xbus_addr;
input otp_xbus_wr;
input [7:0] otp_xbus_din;
output [7:0] otp_xbus_dout;

output [6:0] xbus_addr;
output xbus_wr;
output [7:0] xbus_din;
input [7:0] xbus_dout;

input sys_clk;
input rst_n;

// define states in fsm for choosing otp or i2c interface
typedef enum {IDLE, OTP_ACCESS, I2C_ACCESS} apb_fsm_t;
apb_fsm_t apb_fsm_r, apb_fsm_next_w;

// implement fsm for otp or i2c choosing combine with apb mux
// specification v1.1
// Reset usb chip, the FSm moves to OTP to be ready for a loading data transaction
// Finish first loading data, it moves to IDLE
// Based on otp_busy and i2c_busy situation, next state is determined.
always @(posedge sys_clk or negedge rst_n)
  begin
    if (rst_n == 0)
      apb_fsm_r <= OTP_ACCESS;
    else
      apb_fsm_r <= apb_fsm_next_w;	
  end
  
always @(*)
  begin
    if ((otp_busy == 0) && (i2c_busy == 0))
	  apb_fsm_next_w = IDLE;
	else begin
      case (apb_fsm_r)
	    IDLE: if ((otp_busy == 1) && (i2c_busy == 0)) apb_fsm_next_w = OTP_ACCESS;
			else if ((otp_busy == 0) && (i2c_busy == 1)) apb_fsm_next_w = I2C_ACCESS;
			else apb_fsm_next_w = IDLE;
		OTP_ACCESS: if ((otp_busy == 0) && (i2c_busy == 0)) apb_fsm_next_w == IDLE;
			else apb_fsm_next_w = OTP_ACCESS;
		I2C_ACCESS: if (i2c_busy == 0) apb_fsm_next_w = IDLE;
			else apb_fsm_next_w = I2C_ACCESS;
		default: apb_fsm_next_w = IDLE;
      endcase	  
	end
  end

// generated mux to choose otp or i2c interface for input
always @(*)
  begin
    if ((apb_fsm_r == IDLE) || (apb_fsm_r == I2C_ACCESS))
	  begin
	    xbus_addr = i2c_xbus_addr;
		xbus_wr = i2c_xbus_wr;
		xbus_din = i2c_xbus_din;
	  end
	else 
	  begin
		xbus_addr = otp_xbus_addr;
		xbus_wr = otp_xbus_wr;
		xbus_din = otp_xbus_din;
	  end
  end
  
// generated mux to choose otp or i2c interface for output 
always @(*)
  begin
    if ((apb_fsm_r == IDLE) || (apb_fsm_r == I2C_ACCESS))
	  begin
	    i2c_xbus_dout = xbus_dout;
		otp_xbus_dout = 8'h00;
	  end
	else 
	  begin
		i2c_xbus_dout = 8'h00;
		otp_xbus_dout = xbus_dout;
	  end
  end
  

endmodule