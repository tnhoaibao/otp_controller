# Project for otp controller version 1.2

# Features
- Communicate with host processor via I2C interface
- Load OTP values to the register file in the beginning (boot phase), or when there is a NVM load request in the test mode
- Program OTP in the test mode

# File distribution  (v1.2)
 
top ------ i2c verilog files (will be updated)
     -
	 -
	 ----- otp_top ------ otp_main.sv
	                -
					----- apb_mux.sv
					-
					----- otp_rcm.v
					