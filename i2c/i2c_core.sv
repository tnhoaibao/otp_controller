`timescale 1ns/10ps
module i2c_core (
	scl_clk, //SCL rising edge clock
	scl_n_clk, // SCL falling edge clock
	i2c_rst_n, // Reset i2c core
	active_rst_n, // Reset i2c core from active signal
	sda_i, // serial input signal
	sda_o, // serial output signal
	xbus_addr, //Address bus to register file
	xbus_wr, //Write/read control bit to register file
	xbus_din, //Data input bus to register file
	xbus_dout, //Data output bus to register file
	m_i2c_addr, //Config I2C address from register file (for this slave)
	testmode_en, //Enable test mode
	i2c_addr_inv //Inverted second i2c_address bit (signal from pad)
	);
	
	parameter MAX_NOR_REG_ADDR = 8'h7;
	parameter MAX_TEST_REG_ADDR = 8'hf;
	parameter XBUS_ADDR_WIDTH = 4;
	
	input scl_clk;
	input scl_n_clk;
	input i2c_rst_n;
	input active_rst_n;
	input sda_i;
	output sda_o;
	output xbus_addr;
	output xbus_wr;
	output xbus_din;
	input xbus_dout;
	input m_i2c_addr;
	input testmode_en;
	input i2c_addr_inv;
	
	typedef enum {ADDR_IN, ADDR_ACK, ADDR_NACK, REG_ADDR_IN, DATA_OUT, ACK_IN, ACK_OUT, DATA_IN} i2c_fsm_t;
	
	i2c_fsm_t i2c_fsm_r;
	reg [2:0] bit_cnt_r;
	reg [7:0] i2c_addr_r;
	reg [7:0] reg_addr_r;
	reg [7:0] data_in_r;
	wire [6:0] m_i2c_addr;
	wire [6:0] i2c_addr_s;
	reg sda_o;
	wire [7:0] xbus_din;
	wire [XBUS_ADDR_WIDTH-1:0] xbus_addr;
	reg xbus_wr;
	wire [7:0] xbus_dout;
	wire addr_valid_s; //Check if register address is valid or not
	
	//Calculate i2c address
	assign i2c_addr_s = {m_i2c_addr[6:2], (m_i2c_addr[1] ^ i2c_addr_inv), m_i2c_addr[0]};
	
	//FSM process
	always @ (posedge scl_clk or negedge i2c_rst_n)
		begin
			if (i2c_rst_n == 0)
				i2c_fsm_r <= ADDR_IN;
			else
				case (i2c_fsm_r)
					ADDR_IN : if (bit_cnt_r == 3'b111)
						if (i2c_addr_r[6:0] == i2c_addr_s)
							i2c_fsm_r <= ADDR_ACK;
						else
							i2c_fsm_r <= ADDR_NACK;
					ADDR_ACK : if (i2c_addr_r[0] == 0)
						i2c_fsm_r <= REG_ADDR_IN;
					else
						i2c_fsm_r <= DATA_OUT;
					DATA_OUT : if (bit_cnt_r == 3'b111)
						i2c_fsm_r <= ACK_IN;
					ACK_IN : if (sda_i == 1'b0)
						i2c_fsm_r <= DATA_OUT;
					else
						i2c_fsm_r <= ADDR_NACK;
					REG_ADDR_IN : if (bit_cnt_r == 3'b111)
						i2c_fsm_r <= ACK_OUT;
					ACK_OUT : i2c_fsm_r <= DATA_IN;
					DATA_IN : if (bit_cnt_r == 3'b111)
						i2c_fsm_r <= ACK_OUT;
					default : i2c_fsm_r <= ADDR_IN;
				endcase
		end
	
	//Bit counter process
	always @ (posedge scl_clk or negedge i2c_rst_n)
		begin
			if (i2c_rst_n == 0)
				bit_cnt_r <= 3'b000;
			else
				if ((i2c_fsm_r == ADDR_IN) || (i2c_fsm_r == DATA_OUT) || (i2c_fsm_r == REG_ADDR_IN) || (i2c_fsm_r == DATA_IN))
					//Increase counter when shift in bit
					bit_cnt_r <= bit_cnt_r + 1;
				else
					//Reset counter when in other states
					bit_cnt_r <= 3'b000;
		end
		
	// Shift in i2c address
	always @ (posedge scl_clk or negedge i2c_rst_n)
		begin
			if (i2c_rst_n == 0)
				i2c_addr_r <= 0;
			else
				if (i2c_fsm_r == ADDR_IN)
					// Shift in i2c address and command bit
					i2c_addr_r <= {i2c_addr_r[6:0], sda_i};
		end
		
	// Shift and count register address
	always @ (posedge scl_clk or negedge active_rst_n)
		begin
			if (active_rst_n == 0)
				reg_addr_r <= 0;
			else
				if (i2c_fsm_r == REG_ADDR_IN)
					//Shift in register address
					reg_addr_r <= {reg_addr_r[6:0], sda_i};
				else if ((((i2c_fsm_r == ACK_IN) && (sda_i == 0)) || (xbus_wr == 1)) && (reg_addr_r != 8'hff))
					//Increase register address when receive ack_in, or send out ack_out
					reg_addr_r <= reg_addr_r + 1;
		end
		
	// Shift in input data
	always @ (posedge scl_clk or negedge i2c_rst_n)
		begin
			if (i2c_rst_n == 0)
				data_in_r <= 0;
			else if (i2c_fsm_r == DATA_IN)
				// Shift in data
				data_in_r <= {data_in_r[6:0], sda_i};
		end
		
	// Write data to register via xbus
	assign xbus_din = (xbus_wr == 1'b1)?data_in_r:0;
		
	// xbus address
	assign xbus_addr = ((xbus_wr == 1'b1) || (i2c_fsm_r == DATA_OUT))?reg_addr_r[XBUS_ADDR_WIDTH-1 : 0]:0;
	
	//Check address range valid
	//In normal mode (testmode_en = 0) the register address should not be larger than the max address of normal register
	//In test mode (testmode_en = 1) the register address should not be larger than the max address of test register
	assign addr_valid_s = (((reg_addr_r > MAX_NOR_REG_ADDR) && (testmode_en == 0)) || ((reg_addr_r > MAX_TEST_REG_ADDR) && (testmode_en == 1)))?0:1;
	
	//Condition to xbus write control bit
	always @ (posedge scl_clk or negedge i2c_rst_n)
		begin
			if (i2c_rst_n == 0)
				xbus_wr <= 0;
			else
				if ((i2c_fsm_r == DATA_IN) && (bit_cnt_r == 3'b111) && (addr_valid_s == 1))
					xbus_wr <= 1;
				else
					xbus_wr <= 0;
		end
		
	//Generate the SDA out
	always @ (posedge scl_n_clk or negedge i2c_rst_n)
		begin
			if (i2c_rst_n == 0)
				sda_o <= 1;
			else
				if (i2c_fsm_r == DATA_OUT)
					sda_o <= xbus_dout[~bit_cnt_r];
				else if (i2c_fsm_r == ACK_OUT)
					sda_o <= ~addr_valid_s;
				else if (i2c_fsm_r == ADDR_ACK)
					sda_o <= 0;
				else
					sda_o <= 1;
		end
		
endmodule