`timescale 1ns/10ps

module top (
	sys_clk, 	//system clock, 200MHz clock generated by LO
	rst_n,		//power on reset, active low
	//sent/received to/from register file
	xbus_addr,	//address bus to access reg file
	xbus_din,	//data bus to access reg file
	xbus_dout,	//data bus from reg file
	xbus_wr,	//enable signal indicates read or write data to register file
	i_run_test_mode,//input signal indicates that usb chip is in test mode or not, 1-test mode, 0-normal mode
	i_otp_read_n,	//enable read mode of efuse controller, active low
	i_otp_prog,		//enable program mode of efuse controller
	reg_file_clkm	// clock for reg file, either i2c clock scl or system clock
	//sent/received to/from otp memory
	o_otp_vddqsw,	//enable high voltage LDO for efuse programming, disable for read
	o_otp_csb,		//otp select enable, active low for programming/reading
	o_otp_strobe,	//output signal used to turn on the array for read/program access
	o_otp_load,		//output signal used to turn on sense amplifier (in otp mem) and load data into latch (in otp mem)
	i_otp_q,		//parallel data from efuse
	o_otp_addr,		//address access to otp mem
	o_otp_pgenb,	//program enable, active low
	//for dft implement
	scan_en,		//scan enable
	scan_clk,		//scan clock
	//sent/received to/from i2c interface or correspoding module
	i2c_sda_clk,	//clock signal from I2C SDA
	i2c_sda_n_clk,	//clock signal from inverted I2C SDA
	i2c_scl,		//I2C signal SCL
	slow_clk,		//Slow clock for I2C watchdog
	i2c_stop_rst_n,	//Reset signal for I2C from STOP bit
	i2c_scl_rst_n,	//Reset signal for I2C SCL
	i2c_rst_n,		//Reset signal for I2C module
	i2c_wd_en_n,	//Control bit to enable I2C watchdog
	i2c_wd_sel,		//Control bit to select I2C watchdog time
	i2c_active,		//I2C active bit
	i2c_start,		//I2C start bit
	i2c_stop,		//I2C stop bit	
	i2c_wd_rst,		//I2C stop bit
	i2c_scl_clk,	//Clock signal using I2C SCL
	i2c_scl_n_clk,	//Clock using inverted I2C SCL
	i2c_active_rst_n,//Reset signal for I2C from active bit
	i2c_sda_i,		//I2C input data
	i2c_sda_o,		//I2C output data
	m_i2c_addr,		//I2C address
	i2c_addr_inv,	//Inverted bit for I2C address
	hif_idle		//idle signal for host interface		
);	

input sys_clk;
input rst_n;

output [6:0] xbus_addr;
output [7:0] xbus_din;
input [7:0] xbus_dout;
output xbus_wr;
input i_run_test_mode;
input i_otp_prog;
input i_otp_read_n;

output o_otp_vddqsw;
output o_otp_csb;
output o_otp_strobe;
output o_otp_load;
input [7:0] i_otp_q;
output o_otp_addr;
output o_otp_pgenb;

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
input [6:0] m_i2c_addr;
input i2c_addr_inv;
output hif_idle;

wire otp_busy_w;
wire [6:0] i2c_xbus_addr;
wire [7:0] i2c_xbus_din;
wire [7:0] i2c_xbus_dout;
wire i2c_xbus_wr;
wire [6:0] otp_xbus_addr;
wire [7:0] otp_xbus_din;
wire [7:0] otp_xbus_dout;
wire otp_xbus_wr;
wire rcm_sys_clk;

wire otp_done = ~otp_busy_w;
wire i2c_busy_w = ~hif_idle;

// Instantiate i2c top module
i2c_top i2c_top_i (
.rst_n				(rst_n				),
.otp_done			(otp_done			),
.testmode_en		(i_run_test_mode	),
.xbus_addr			(i2c_xbus_addr		),
.xbus_wr			(i2c_xbus_wr		),
.xbus_din			(i2c_xbus_din		),
.xbus_dout			(i2c_xbus_dout		),
.i2c_sda_clk		(i2c_sda_clk		),
.i2c_sda_n_clk		(i2c_sda_n_clk		),
.i2c_scl			(i2c_scl			),
.slow_clk			(slow_clk			),
.i2c_stop_rst_n		(i2c_stop_rst_n		),
.i2c_scl_rst_n		(i2c_scl_rst_n		),
.i2c_rst_n			(i2c_rst_n			),
.i2c_wd_en_n		(i2c_wd_en_n		),
.i2c_wd_sel			(i2c_wd_sel			),
.i2c_active			(i2c_active			),
.i2c_start			(i2c_start			),
.i2c_stop			(i2c_stop			),
.i2c_wd_rst			(i2c_wd_rst			),
.i2c_scl_clk		(i2c_scl_clk		),
.i2c_scl_n_clk		(i2c_scl_n_clk		),
.i2c_active_rst_n	(i2c_active_rst_n	),
.i2c_sda_i			(i2c_sda_i			),
.i2c_sda_o			(i2c_sda_o			),
.m_i2c_addr			(m_i2c_addr			),
.i2c_addr_inv		(i2c_addr_inv		),
.hif_idle			(hif_idle			)
);

// Instantiate apb mux module
apb_mux apb_mux_i (
.i2c_busy			(i2c_busy_w			),
.otp_busy			(otp_busy_w			),
.i2c_xbus_addr		(i2c_xbus_addr		),
.i2c_xbus_wr		(i2c_xbus_wr		),
.i2c_xbus_din		(i2c_xbus_din		),
.i2c_xbus_dout		(i2c_xbus_dout		),
.otp_xbus_addr		(otp_xbus_addr		),
.otp_xbus_wr		(otp_xbus_wr		),
.otp_xbus_din		(otp_xbus_din		),
.otp_xbus_dout		(otp_xbus_dout		),
.xbus_addr			(xbus_addr			),
.xbus_wr			(xbus_wr			),
.xbus_dout			(xbus_dout			),
.xbus_din			(xbus_din			),
.sys_clk			(sys_clk			),
.rst_n				(rst_n				)
);

// Instantiate otp controller module
otp_main otp_main_i (
.sys_clk			(rcm_sys_clk		),
.rst_n				(rst_n				),
.i_i2c_busy			(i_i2c_busy			),
.i_run_test_mode	(i_run_test_mode	),
.o_otp_vddqsw		(o_otp_vddqsw		),
.o_otp_csb			(o_otp_csb			),
.o_otp_strobe		(o_otp_strobe		),
.o_otp_load			(o_otp_load			),
.i_otp_q			(i_otp_q			),
.o_otp_addr			(o_otp_addr			),
.o_otp_pgenb		(o_otp_pgenb		),
.o_xbus_din			(otp_xbus_din		),
.o_xbus_addr		(otp_xbus_addr		),
.i_xbus_dout		(otp_xbus_dout		),
.i_otp_read_n		(i_otp_read_n		),
.i_otp_prog			(i_otp_prog			),
.o_xbus_wr			(otp_xbus_wr		),
.o_otp_busy			(otp_busy_w			)
);

// Instantiate otp_rcm module
otp_rcm otp_rcm_i (
.i2c_busy			(i2c_busy_w			),
.passcode_en		(i_run_test_mode	),
.otp_busy			(otp_busy_w			),
.scan_en			(scan_en			),
.scan_clk			(scan_clk			),
.i2c_clk			(i2c_reg_file_clk	),	//register file clock generated from pure rcm module
.sys_clk			(sys_clk			),
.rst_n				(rst_n				),
.rcm_reg_clk		(reg_file_clk		),
.rcm_sys_clk		(rcm_sys_clk		)
);

endmodule