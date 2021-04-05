`timescale 1ns/10ps
module i2c_master_2 ( 
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

typedef enum {STATE_IDLE, STATE_START, STATE_ADDR, STATE_RW, STATE_WACK, STATE_DATA, STATE_STOP, STATE_WACK2, STATE_SIGNAL, STATE_WAIT} fsm_state;
fsm_state state;

parameter num_of_reg = 30;		//number of register file used in this test. In reality, 128 registers will be used.
parameter number_stop = 28; 	//data index of final register will be read/write data
parameter number_start = 18;    //data index of first register will be read/write data
parameter addr_device = 7'h0A;

reg [4:0] number_data;			//data related to current register, data[number_data]
reg [7:0] addr;					//address of first register
reg [7:0] data[0 : number_stop];//data array used to write to register file
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
		addr <= 8'd18;				//first register will be read/write to register file						
		count <= 3'd6;
		count_data <= 3'd7;
		data[18] <= 8'hFF;
		data[19] <= 8'hFD;
		data[20] <= 8'hDF;
    	data[21] <= 8'h00;
     	data[22] <= 8'h88;
    	data[23] <= 8'h77;
     	data[24] <= 8'h66;
     	data[25] <= 8'h55;
    	data[26] <= 8'h44;
     	data[27] <= 8'h33;
      	data[28] <= 8'h22;
      	data[29] <= 8'h11;
       	data[30] <= 8'h00;
		number_data <= number_stop;
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
				else i2c_sda <= addr[count];

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
					number_data <= number_start;
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
				if (number_data == number_stop) begin
					state <= STATE_STOP;			
				end else begin
					state <= STATE_DATA;
					number_data <= number_data + 1;
				end
			end
			
			STATE_STOP: begin
				i2c_dout <= 1'b1;
				i2c_sda <= 1'b1;
				state <= STATE_WAIT;
			end

			STATE_WAIT: begin
				i2c_dout <= 1'b1;
				i2c_sda <= 1'b1;
				state <= STATE_WAIT;
			end	
		endcase	
	end
end
endmodule

