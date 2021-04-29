`timescale 1ns/10ps
module i2c_master_passcode ( 
	clk_scl,		//clock scl used to generate scl signal for i2c master
	clk_sda,		//clock sda used to generate sda signal for i2c master, delay 10ns 
	rst_n,			//reset signal for i2c master, active low
	i2c_sda,		//output i2c sda sent to i2c slave
	i2c_scl,		//output i2c scl sent to i2c slave
	i2c_dout		//no connect
);

input clk_scl;
input clk_sda;
input rst_n;
output i2c_sda;
output i2c_scl;
output i2c_dout;		

wire clk_scl;
wire clk_sda;
wire rst_n;
reg i2c_sda;
wire i2c_scl;
reg i2c_dout;		

typedef enum {STATE_IDLE, STATE_START, STATE_ADDR, STATE_RW, STATE_WACK, STATE_DATA, STATE_STOP, STATE_STOP_PRE, STATE_WACK2, STATE_SIGNAL, STATE_WAIT} fsm_state;
fsm_state state;

parameter addr_device = 7'h0A;
parameter addr_passcode = 8'h05; //address of passcode register
parameter addr_otp = 8'h04;		//address contains read/write enable for otp transaction

reg [2:0] number_data;			//data related to current register, data[number_data]
reg [7:0] data[0:6];//data array used to write to register file
reg [2:0] count;				//down counter for device/register address
reg [2:0] count_data;			//down counter for data
reg [3:0] count_state_wait;		//up counter for waiting time between 2 i2c transaction

reg addr_reg_device_flag;		//flag indicates that i2c master transfer devive addr or reg addr
reg i2c_scl_en;

assign i2c_scl = (i2c_scl_en == 1'b0)? 1'b1 : ~clk_scl;

always @(negedge clk_scl or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		i2c_scl_en <= 1'b0;
	end else begin
		if ((state == STATE_IDLE) || (state == STATE_START) || (state == STATE_STOP)) begin
			i2c_scl_en <= 1'b0;
		end else begin
			i2c_scl_en <= 1'b1;
		end
	end
end


always @(posedge clk_sda or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		state <= STATE_IDLE;
		i2c_dout <= 1'b1;
		i2c_sda <= 1'b1;						
		count <= 3'd6;
		count_data <= 3'd7;
		data[0] <= 8'h50;			//define for P
		data[1] <= 8'h48;			//define for H
		data[2] <= 8'h53;			//define for S
		data[3] <= 8'h47;			//define for G
		data[4] <= 8'h4E;			//define for N
		data[5] <= 8'h58;			//define for X
		data[6] <= 8'h00;				//define register 04, (8'h00) read otp or (8'h11) write otp, nothing (8'h01)
		number_data <= 0;
		addr_reg_device_flag <= 1'b0;
	end else begin
		case(state)
			STATE_IDLE: begin 	//idle	
				i2c_sda <= 1'b1;
				state <= STATE_START;
				i2c_dout <= 1'b1;
			end
			
			STATE_START: begin	//start
				i2c_sda <= 1'b0;
				i2c_dout <= 1'b1;
				state <= STATE_ADDR;
				count <= 3'd6;
			end
			
			STATE_ADDR: begin 	// msb addr bit
				i2c_dout <= 1'b1;
				if (addr_reg_device_flag == 1'b0) i2c_sda <= addr_device[count];
				else if (number_data != 6)
					i2c_sda <= addr_passcode[count];
				else
					i2c_sda <= addr_otp[count];
					
				if (count == 0) begin
					if (addr_reg_device_flag == 1'b0) state <= STATE_RW;
					else state <= STATE_WACK;
				end else begin
					count <= count - 1;
				end
			end
			
			STATE_RW: begin
				i2c_sda <= 1'b0;
				state <= STATE_WACK;
				i2c_dout <= 1'b1;
			end
			
			STATE_WACK: begin
				i2c_dout <= 1'b0;
				if (addr_reg_device_flag == 1'b0) begin
					state <= STATE_ADDR;
					count <= 3'd7;
					addr_reg_device_flag <= 1'b1;
				end else begin
					i2c_sda <= 1'b0;
					state <= STATE_DATA;
					count_data <= 3'd7;
					addr_reg_device_flag <= 1'b0;
				end
			end
			
			STATE_DATA: begin
				i2c_sda <= data[number_data][count_data];
				if (count_data == 0) begin
	 				state <= STATE_WACK2;
					i2c_dout <= 1'b1;
				end else begin
					count_data <= count_data - 1;
					i2c_dout <= 1'b1;
				end
			end
			 
			STATE_WACK2: begin
				i2c_dout <= 1'b0;
				count_data <= 3'd7;
				i2c_sda <= 1'b0;
				state <= STATE_STOP_PRE;
			end
			
			STATE_STOP_PRE: begin
				i2c_dout <= 1'b1;
				i2c_sda <= 1'b0;
				state <= STATE_STOP;
			end
			
			STATE_STOP: begin
				i2c_dout <= 1'b1;
				i2c_sda <= 1'b1;
				state <= STATE_WAIT;
			end

			STATE_WAIT: begin
				i2c_dout <= 1'b1;
				i2c_sda <= 1'b1;
				if (number_data == 6) begin
					number_data <= number_data;
					state <= STATE_WAIT;
				end else begin 
					number_data = number_data + 1;
					state <= STATE_IDLE;
				end
			end	
		endcase	
	end
end
endmodule

