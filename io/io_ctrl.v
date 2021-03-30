`timescale 1ns/10ps
module io_ctrl (
	i2c_sda_i, // input data for i2c interface (put this signal to i2c delay block)
	i2c_sda_o, // output data for i2c_interface (put this signal to i2c delay block)
	sdx_input, // input value for SDX pad 
	sdx_output, // output to sdx pad
	sdx_output_en_n, //output enable signal for SDX pad
	);
	
output i2c_sda_i;
input i2c_sda_o;
input sdx_input;
output sdx_output;
output sdx_output_en_n;

reg i2c_sda_i;
reg sdx_output;
reg sdx_output_en_n;

always @ (*)
  begin
    // I2C interface selected
    i2c_sda_i = sdx_input;
    sdx_output = 1'b0;
    sdx_output_en_n = i2c_sda_o;
  end
	
endmodule