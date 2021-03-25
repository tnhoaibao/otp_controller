`timescale 1ns/10ps
module i2c_reset (
	otp_done , // Signal indicating OTP (boot for example) done
	sda_n_clk , // Falling edge clock from SDA signal
	scl, // SCL data signal
	sda_clk, // Rising edge clock from SDA signal
	slow_clk, // Slow clock signal
	i2c_stop_rst_n, // I2C reset signal from STOP bit
	scl_rst_n, // SCL reset signal
	i2c_rst_n, // I2C reset signal
	i2c_wd_en_n, //Config bit watchdog enable
	i2c_wd_sel, //Config bit watchdog selection
	active, // ACTIVE bit
	stop, // STOP bit
	start, // START bit
	wd_rst // Watchdog reset request
	);
	
	parameter WD_WIDTH = 8;
	parameter WD_1 = 8'b01000000;
	parameter WD_2 = 8'b10000000;
	
	input otp_done;
	input sda_n_clk;
	input scl;
	input sda_clk;
	input slow_clk;
	input i2c_stop_rst_n;
	input scl_rst_n;
	input i2c_rst_n;
	input i2c_wd_en_n;
	input i2c_wd_sel;
	output active;
	output stop;
	output start;
	output wd_rst;
	
	reg [WD_WIDTH-1 : 0] wd_cnt; //Watchdog counter
	reg active;
	reg start;
	reg stop;
	
	//Condition to reset due to watchdog
	assign wd_rst = ((i2c_wd_en_n == 1) && (((i2c_wd_sel == 0) && (wd_cnt == WD_1)) || ((i2c_wd_sel == 1) && (wd_cnt == WD_2))))?1:0;
	
	// Watchdog counter procedure
	always @ (posedge slow_clk or negedge i2c_rst_n)
		begin
			if (i2c_rst_n == 0)
				wd_cnt <= 0;
			else
				if ((i2c_wd_en_n == 1) && (wd_rst == 0))
					wd_cnt <= wd_cnt + 1;
		end
		
	//Active bit procedure
	always @ (posedge sda_n_clk or negedge i2c_stop_rst_n)
		begin
			if (i2c_stop_rst_n == 0)
				active <= 0;
			else
				if (scl == 1)
					active <= otp_done;
		end
		
	//Stop bit procedure
	always @ (posedge sda_clk or negedge i2c_rst_n)
		begin
			if (i2c_rst_n == 0)
				stop <= 0;
			else
				stop <= scl;
		end
		
	//Start bit procedure
	always @ (posedge sda_n_clk or negedge scl_rst_n)
		begin
			if (scl_rst_n == 0)
				start <= 0;
			else
				start <= 1;
		end
		
endmodule