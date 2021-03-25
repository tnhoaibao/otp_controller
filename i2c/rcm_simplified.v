`timescale 1ns/10ps
module rcm_simplified (
	xtal_clk, // input crystal clock
	por_rst_n, // input POR reset
	hif_active, // Interface ACTIVE bit
	hif_start, // Interface START bit
	hif_stop, // Interface STOP bit
	hif_scl, // Interface SCL signal
	hif_watchdog, // Watchdog interrupt
	hif_scl_del, // delay of SCL signal
	hif_sda_del, // delay of SDA signal
	slow_clk_in, // Slow clock from ring osc
	hif_select, // Interface select signal
	hif_idle, // Signal indicating host interface idle
	i2c_wd_en_n, // Enable I2C watchdog from register file
	i2c_rst_n, // Reset I2C interface without I2C register address reg
	i2c_active_rst_n, // Reset I2C register address reg
	i2c_scl_rst_n, // Reset START bit from scl signal
	i2c_stop_rst_n, // Reset ACTIVE bit from STOP bit and watchdog
	i2c_clk, // I2C clock
	i2c_clk_n, // I2C inverted clock
	reg_file_clk, // Register file clock
	i2c_sda_clk, // I2C clock using SDA signal for START, STOP, ACTIVE bit
	i2c_sda_clk_n, // I2C clock using inverted SDA signal
	slow_clk, // Slow clock for I2C watchdog
	sys_clk, // System clock 
	shadow_reg_clk, // clock for shadow register
	slow_clk_en, // output enable signal for the ring oscillator
	rst_n // System reset
	);
	
	input xtal_clk;
	input por_rst_n;
	input hif_active;
	input hif_start;
	input hif_stop;
	input hif_scl;
	input hif_watchdog;
	input hif_scl_del;
	input hif_sda_del;
	input slow_clk_in;
	input hif_select;
	input hif_idle;
	input i2c_wd_en_n;
	output i2c_rst_n;
	output i2c_active_rst_n;
	output i2c_scl_rst_n;
	output i2c_stop_rst_n;
	output i2c_clk;
	output i2c_clk_n;
	output reg_file_clk;
	output i2c_sda_clk;
	output i2c_sda_clk_n;
	output slow_clk;
	output sys_clk;
	output shadow_reg_clk;
	output slow_clk_en;
	output rst_n;
	
	reg rst_sync1_n, rst_sync2_n; // Synchronized reset signal after 2 FF
	reg i2c_clk;
	reg i2c_clk_n;
	reg reg_file_clk;
	wire sys_cg1_clk_s; //system clock after clock gate for register file 
	wire sys_cg2_clk_s; // System clock after clock gate for shadow register
	reg i2c_sda_clk;
	reg i2c_sda_clk_n;
	reg slow_clk_en;
	
	// Synchronize reset signal with system clock using 2 FF
	always @ (posedge xtal_clk or negedge por_rst_n)
		begin
			if (por_rst_n == 1'b0)
				begin
					rst_sync1_n <= 1'b0;
					rst_sync2_n <= 1'b0;
				end
			else
				begin
					rst_sync1_n <= 1'b1;
					rst_sync2_n <= rst_sync1_n;
				end
		end
		
	// Send out system reset
	assign rst_n = rst_sync2_n;
		
	// Implement I2C interface reset with active bit
	assign i2c_active_rst_n = rst_sync2_n & hif_active;
	
	// Implement I2C interface reset with START and ACTIVE bit
	assign i2c_rst_n = rst_sync2_n & hif_active & (~hif_start);
	
	// Implement I2C SCL reset for START bit
	assign i2c_scl_rst_n = rst_sync2_n & hif_scl_del;
	
	// Implement I2C reset for ACTIVE bit
	assign i2c_stop_rst_n = rst_sync2_n & (~hif_stop) & (~hif_watchdog);
	
	// Implement SPI clock, I2C clock, and register file clock
	// Use one process to balance delta cycle delay of these clock
	// Note: system clock and register file clock are not balance for simulation but acceptable
	// System clock and register file clock are balance when synthesis
	always @(*)
		begin
			i2c_clk = hif_scl_del;
			i2c_clk_n = ~hif_scl_del;
			reg_file_clk = hif_scl_del;
		end
		
	// Implement I2C SDA and inverted SDA clocks for START STOP and ACTIVE bit
	always @ (*)
		begin
			i2c_sda_clk = hif_sda_del;
			i2c_sda_clk_n = ~hif_sda_del;
		end
	
	// Implement combine clock for FF in clock mux
	assign slow_clk = slow_clk_in;
	assign sys_clk = xtal_clk;
		
	// Implement clock for shadow register
	assign shadow_reg_clk = hif_idle;
	
	// Implement 2 clock gate for register file and shadow register
	
	// Implement enable signal for the ring oscillator
	always @ (posedge shadow_reg_clk or negedge rst_n)
		if (rst_n == 1'b0)
			slow_clk_en <= 1'b1;
		else
			// Enable ring oscillator when we use watchdog and I2C interface mode
			slow_clk_en <= ~(i2c_wd_en_n | hif_select);
	
endmodule