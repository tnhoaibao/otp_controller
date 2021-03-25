`timescale 1ns/10ps
module hif (
	rst_n, // System reset
	otp_done, // signal indicating OTP done
	spi_csb_n_clk, // Clock signal using falling edge of CSB
	spi_csb, // SPI CSB signal
	testmode_en, // test mode enable
	xbus_addr, // xbus address bus
	xbus_wr, // xbus write control signal
	xbus_din, // xbus data in bus
	xbus_dout, // xbus data out bus
	i2c_sda_clk, // clock signal from I2C SDA
	i2c_sda_n_clk, // clock signal from inverted I2C SDA
	i2c_scl, // I2C signal SCL
	slow_clk, // Slow clock for I2C watchdog
	i2c_stop_rst_n, // Reset signal for I2C from STOP bit
	i2c_scl_rst_n, // Reset signal for I2C SCL
	i2c_rst_n, // Reset signal for I2C module
	i2c_wd_en_n, // Control bit to enable I2C watchdog
	i2c_wd_sel, // Control bit to select I2C watchdog time
	i2c_active, // I2C active bit
	i2c_start, // I2C start bit
	i2c_stop, // I2C stop bit
	i2c_wd_rst, // I2C watchdog reset request
	i2c_scl_clk, // Clock signal using I2C SCL
	i2c_scl_n_clk, // Clock using inverted I2C SCL
	i2c_active_rst_n, // Reset signal for I2C from active bit
	i2c_sda_i, // I2C input data
	i2c_sda_o, // I2C output data
	m_i2c_addr, // I2C address
	i2c_addr_inv, // Inverted bit for I2C address
	hif_idle, // idle signal for host interface
	if_select, // Interface protocol selection
	i2c_if, // config bit to use i2c interface explicitly
	spi_if // config bit to use spi interface explicitly
	);
	
parameter MAX_NOR_REG_ADDR = 8'h64;
parameter MAX_TEST_REG_ADDR = 8'h65;
parameter XBUS_ADDR_WIDTH = 7;
	
input rst_n;
input otp_done;
input spi_csb_n_clk;
input spi_csb;
input testmode_en;
output xbus_addr;
output xbus_wr;
output xbus_din;
input xbus_dout;
input i2c_sda_clk;
input i2c_sda_n_clk;
input i2c_scl;
input slow_clk;
input i2c_stop_rst_n;
input i2c_scl_rst_n;
input i2c_rst_n;
input i2c_wd_en_n;
input i2c_wd_sel;
output i2c_active;
output i2c_start;
output i2c_stop;
output i2c_wd_rst;
input i2c_scl_clk;
input i2c_scl_n_clk;
input i2c_active_rst_n;
input i2c_sda_i;
output i2c_sda_o;
input m_i2c_addr;
input i2c_addr_inv;
output hif_idle;
input i2c_if;
input spi_if;
	

reg [XBUS_ADDR_WIDTH-1:0] xbus_addr;
reg xbus_wr;
reg [7:0] xbus_din;
wire [7:0] xbus_dout;
wire [XBUS_ADDR_WIDTH-1:0] i2c_xbus_addr;
wire i2c_xbus_wr;
wire [7:0] i2c_xbus_din;
reg [7:0] i2c_xbus_dout;
wire [6:0] m_i2c_addr;
		
// Generate hif_idle: if i2c interface -> use active bit, if spi_interface -> use CSB
assign hif_idle = ~i2c_active;
	
// interface mux implementation
always @ (i2c_xbus_addr or i2c_xbus_wr or i2c_xbus_din or xbus_dout)
	begin
		xbus_addr = i2c_xbus_addr;
		xbus_wr = i2c_xbus_wr;
		xbus_din = i2c_xbus_din;
		i2c_xbus_dout = xbus_dout;
	end
		
	
// Instantiate I2C reset
i2c_reset i2c_reset_i (
	.otp_done(otp_done),
	.sda_n_clk(i2c_sda_n_clk),
	.scl(i2c_scl),
	.sda_clk(i2c_sda_clk),
	.slow_clk(slow_clk),
	.i2c_stop_rst_n(i2c_stop_rst_n),
	.scl_rst_n(i2c_scl_rst_n),
	.i2c_rst_n(i2c_rst_n),
	.i2c_wd_en_n(i2c_wd_en_n),
	.i2c_wd_sel(i2c_wd_sel),
	.active(i2c_active),
	.stop(i2c_stop),
	.start(i2c_start),
	.wd_rst(i2c_wd_rst)
	);
	
// Instantiate I2C core
i2c_core #(
	.MAX_NOR_REG_ADDR(MAX_NOR_REG_ADDR),
	.MAX_TEST_REG_ADDR(MAX_TEST_REG_ADDR),
	.XBUS_ADDR_WIDTH(XBUS_ADDR_WIDTH)
	) i2c_core_i (
		.scl_clk(i2c_scl_clk),
		.scl_n_clk(i2c_scl_n_clk),
		.i2c_rst_n(i2c_rst_n),
		.active_rst_n(i2c_active_rst_n),
		.sda_i(i2c_sda_i),
		.sda_o(i2c_sda_o),
		.xbus_addr(i2c_xbus_addr),
		.xbus_wr(i2c_xbus_wr),
		.xbus_din(i2c_xbus_din),
		.xbus_dout(i2c_xbus_dout),
		.m_i2c_addr(m_i2c_addr),
		.testmode_en(testmode_en),
		.i2c_addr_inv(i2c_addr_inv)
		);
		
endmodule