`timescale 1ns/10ps
module otp_rcm (	
        i2c_busy, 	//signaling that there is i2c transaction or not
		passcode_en,//signaling that entry test mode
		otp_busy, 	//signaling that there is otp transaction or not
		scan_en, 	//enable scan chain
		scan_clk, 	//scan clock
		i2c_clk,	//i2c interface clock scl
		sys_clk,	//system clock, 200MHz clock generated by LO
		rst_n, 		//system reset
		rcm_reg_clk,//clock sent to register file, multiplexer either sys_clk or i2c_clk
		rcm_sys_clk);//system clock after clock gating
		
input i2c_busy;
input passcode_en;
input otp_busy;
input scan_en;
input scan_clk;
input i2c_clk;
input sys_clk;
input rst_n;

output rcm_reg_clk;
output rcm_sys_clk;

wire i2c_busy;

wire en_sys_clk_pre;  // otp_busy OR (passcode_en AND ~i2c_busy)
wire en_sys_clk; // enable signal after sync with  sys_clk
reg en_sys_clk_r1;
reg en_sys_clk_r2;

wire en_sys_clk_n;
reg en_i2c_clk_r1;
reg en_i2c_clk_r2;
wire en_i2c_clk; //enable signal after sync with i2c_clk

wire i2c_clk_cg; //output i2c_clk of clock gate

wire sys_clk_cg; //output sys_clk of clock gate

wire reg_clk; // sys_clk OR i2c_clk after clock gate stage

//sync en_sys_clk with sys_clk
assign en_sys_clk_pre = otp_busy |(passcode_en & (~i2c_busy));

always @(posedge sys_clk or negedge rst_n)
begin
	if (rst_n == 1'b0)
		begin
			en_sys_clk_r1 <= 1'b0;
			en_sys_clk_r2 <= 1'b0;
		end
	else
		begin
			en_sys_clk_r1 <= en_sys_clk_pre;
			en_sys_clk_r2 <= en_sys_clk_r1;
		end
end
assign en_sys_clk = en_sys_clk_r2;


//sync en_sys_clk_n with i2c_clk
assign en_sys_clk_n = ~en_sys_clk;

always @(posedge i2c_clk or negedge i2c_busy)
begin
	if (i2c_busy == 1'b0)
		begin
			en_i2c_clk_r1 <= 1'b0;
			en_i2c_clk_r2 <= 1'b0;
		end
	else
		begin
			en_i2c_clk_r1 <= en_sys_clk_n;
			en_i2c_clk_r2 <= en_i2c_clk_r1;
		end
end
assign en_i2c_clk = en_i2c_clk_r2;

 // synopsys dc_script_begin
 // set_dont_touch  {CLOCK_GATE_*}
 // set_dont_touch  {OR_REG_CLK}
 // set_dont_touch  {MUX_*} 
 // synopsys dc_script_end 
 
// implement clock gate
CKLHQD8  CLOCK_GTATE_SYS_CLK (	
				.E(en_sys_clk),  //clock gate for sys_clk
				.TE(scan_en), 
				.CPN(sys_clk), 
				.Q(sys_clk_cg));

CKLHQD8 CLOCK_GATE_I2C_CLK (	
				.E(en_i2c_clk), //clock gate for i2c_clk
				.TE(scan_en),
				.CPN(i2c_clk),
				.Q(i2c_clk_cg));

OR2D4 OR_REG_CLK (	
				.A1(i2c_clk_cg),  //i2c_clk_cg OR sys_clk_cg
				.A2(sys_clk_cg),
				.Z(reg_clk));

// implement mux interface
CKMUX2D2 MUX_REG_CLK (		
				.I0(reg_clk), //mux interface for reg_clk
				.I1(scan_clk),
				.S(scan_en),
				.Z(rcm_reg_clk));

CKMUX2D2 MUX_SYS_CLK (		
				.I0(sys_clk_cg), //mux interface for sys_clk
				.I1(scan_clk),
				.S(scan_en),
				.Z(rcm_sys_clk));
endmodule

