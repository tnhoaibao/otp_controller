`timescale 1ns/10ps
module digtop (
por_rst_n,			// input PoR reset
xtal_clk,			// input 200MHz LO clock
// from/to main blocks related to i2c
soft_rst,			// output soft reset, go to PoR generator block
hif_scl,			// input SCL, connect to SCL signal directly
hif_scl_del,		// input SCL, connect to SCL delay signal after I2C delay block
hif_sda_del,		// input SDA, connect to SDA delay signal after i2c delay block
slow_clk_in,		// input slow clock from ring oscillator
slow_clk_en,		// output enable signal for the slow ring oscillator 
sdx_input,			// input SDA, connect to SDA signal from SDA pad
sdx_output,			// output SDA, connect to SDA (output pin) pad
sdx_output_en_n,	// output enable signal for SDA pad
hif_idle_out,		// output HIF IDLE, send out hif_idle signal before feedback to use as clock
hif_idle_feedback,	// input HIF_IDLE, hif_dile feedback signal
i2c_clk_after_del,	// input SCL, after i2c delay block
i2c_din_after_del,	// input SDA, after i2c delay block
i2c_din_before_del, // output SDA, check if we can remove this signal
i2c_dout_after_del, // input SDA output, after i2c delay
i2c_dout_before_del,// output SDA output, check if we can remove this signal
clk_en,				// output enable 200MHz LO clock
i2c_del,			// output, trimming delay timing of i2c delay	
reg05_wr,			// output, contains read/program enable for otp controller
// from/to otp memory
o_otp_vddqsw,		// output VDDQ enable for 2.5LDO, connect to otp memory
o_otp_csb,			// output CSB, enable a read or program transaction, connect to otp memory
o_otp_strobe,		// output STROBE, used as clock for otp memory
o_otp_load,			// output LOAD, enable read transaction, connect to otp memory, active high
i_otp_q,			// input parallel 8-bits data, connect to otp memory, get data at falling edge of STROBE
o_otp_addr,			// output ADDRESS, 10 bits (7 for address, 3 for order of bit), connect to otp memory
o_otp_pgenb,		// output PGENB, enable program transaction, connect to otp memory, active low
scan_en,			// input scan enable, check if we will get this signal from reg file
scan_clk,			// input scan clock
// output, trimming analog/digital circuits
// connect to corresponding circuits directly
reg04_exam,		
reg09_wr,	
reg11_wr,		
reg12_wr,	
reg13_wr,	
reg14_wr,	
reg15_wr,	
reg16_wr,	
LFPS_EN_CONTROLLER,	
reg18_wr,		
reg19_wr,		
reg20_wr,		
reg21_wr,		
reg22_wr,		
reg23_wr,		
reg24_wr,		
reg25_wr,		
reg26_wr,		
reg27_wr,		
reg28_wr,		
EN_EMP,
TX_EN_CONTROLLER,
reg30_wr,		
reg31_wr,		
reg32_wr,		
reg33_wr,		
reg34_wr,		
reg35_wr,		
reg36_wr,		
reg37_wr,		
reg38_wr,		
reg39_wr,		
reg40_wr,		
reg41_wr,		
reg42_wr,		
SYS_IMP_EN,	
reg44_wr,		
TIME100NS_OFF,	
EMP_VALUE_CTRL,	
LPMM_EN,
TIME40NS, 
TIME100NS_ON,   	
TIME300NS, 
TIME60NS_H,
TIME70NS_H,
TIME200NS, 
TIME170NS, 
TIME1MS, 
TIME16MS,
TIME50U, 
TIMEATT, 
TIME130MS,
TIME460MS,
ATT_PULSE_HIGH,
TIMEISPLUG,
TIME_EN_1,
TIME_EN_2, 
TIME_EN_3, 
TIME_EN_4, 
TIME_EN_5, 
TIME_EN_6, 
TIME60NS_L,
TIME70NS_L,
CTR_LFPS_RX, 
CTR_SS_RX, 
CTR_LFPS_TX,
CTR_SS_TX, 
ATT_PULSE_LOW,
TIME_HOLD_LOW,   
CTR_IS_PLUG, 
CTR_EN_LOW_IMP,
CTR_VALID_ATT,
CTR_TIMEOUT460,
SEL_STATE,		
SEL_PLUG_ATT,   	
AGC_125U_EN,		    
AGC_EN,			
TIA_ZPSW,		
BF_1EN,			
BF_2EN,			
BF_EN660,		
BF_EN500,		
BF_EN2,			
LA_BIAS1,		
LA_BIAS2,		
LA_BIAS3,		
LA_VREFA,		
LA_VREF,		    
reg123_wr,		
reg95_wr,		
MUX_GEN_V1P5, 	
PTAT_IEQ,		
reg97_wr,		
reg98_wr,		
reg102_wr,		
reg103_wr,		
reg104_wr,		
reg105_wr,		
reg106_wr,		
reg107_wr,		
reg108_wr,		
reg109_wr,		
reg110_wr,		
LA_RD2,		
LA_RD1,		
LA_RD4,		
LA_RD3,		
LA_RD6,		
LA_RD5,		
reg114_wr,		
reg115_wr,		
BF_CMFB,	    
BF_SRC,	
reg117_wr,		
reg118_wr,		
BF_RD2,	
BF_RD1,	
reg120_wr,		    					
reg124_wr,		
reg125_wr	
);

input por_rst_n;				// input PoR reset
input xtal_clk;			// input 200MHz LO clock
output soft_rst;			// output soft reset, go to PoR generator block
input hif_scl;			// input SCL, connect to SCL signal directly
input hif_scl_del;		// input SCL, connect to SCL delay signal after I2C delay block
input hif_sda_del;		// input SDA, connect to SDA delay signal after i2c delay block
input slow_clk_in;		// input slow clock from ring oscillator
output slow_clk_en;		// output enable signal for the slow ring oscillator 
input sdx_input;			// input SDA, connect to SDA signal from SDA pad
output sdx_output;			// output SDA, connect to SDA (output pin) pad
output sdx_output_en_n;	// output enable signal for SDA pad
output hif_idle_out;		// output HIF IDLE, send out hif_idle signal before feedback to use as clock
input hif_idle_feedback;	// input HIF_IDLE, hif_dile feedback signal
input i2c_clk_after_del;	// input SCL, after i2c delay block
input i2c_din_after_del;	// input SDA, after i2c delay block
output i2c_din_before_del; // output SDA, check if we can remove this signal
input i2c_dout_after_del; // input SDA output, after i2c delay
output i2c_dout_before_del;// output SDA output, check if we can remove this signal
output clk_en;				// output enable 200MHz LO clock
output [3:0] i2c_del;			// output, trimming delay timing of i2c delay	
output [7:0] reg05_wr;			// output, contains read/program enable for otp controller
// output, to otp memory
output o_otp_vddqsw;		// output VDDQ enable for 2.5LDO, connect to otp memory
output o_otp_csb;			// output CSB, enable a read or program transaction, connect to otp memory
output o_otp_strobe;		// output STROBE, used as clock for otp memory
output o_otp_load;			// output LOAD, enable read transaction, connect to otp memory, active high
input [7:0] i_otp_q;			// input parallel 8-bits data, connect to otp memory, get data at falling edge of STROBE
output [9:0] o_otp_addr;			// output ADDRESS, 10 bits (7 for address, 3 for order of bit), connect to otp memory
output o_otp_pgenb;		// output PGENB, enable program transaction, connect to otp memory, active low
input scan_en;			// input scan enable, check if we will get this signal from reg file
input scan_clk;			// input scan clock
// output, trimming analog/digital circuits
// connect to corresponding circuits directly
output reg04_exam;		
output reg09_wr;		
output reg11_wr;		
output reg12_wr;	
output reg13_wr;	
output reg14_wr;	
output reg15_wr;	
output reg16_wr;	
output LFPS_EN_CONTROLLER;	
output reg18_wr;		
output reg19_wr;		
output reg20_wr;		
output reg21_wr;		
output reg22_wr;		
output reg23_wr;		
output reg24_wr;		
output reg25_wr;		
output reg26_wr;		
output reg27_wr;		
output reg28_wr;		
output EN_EMP;
output TX_EN_CONTROLLER;
output reg30_wr;		
output reg31_wr;		
output reg32_wr;		
output reg33_wr;		
output reg34_wr;		
output reg35_wr;		
output reg36_wr;		
output reg37_wr;		
output reg38_wr;		
output reg39_wr;		
output reg40_wr;		
output reg41_wr;		
output reg42_wr;		
output SYS_IMP_EN;	
output reg44_wr;		
output TIME100NS_OFF;	
output EMP_VALUE_CTRL;	
output LPMM_EN;
output TIME40NS; 
output TIME100NS_ON;   	
output TIME300NS; 
output TIME60NS_H;
output TIME70NS_H;
output TIME200NS; 
output TIME170NS; 
output TIME1MS; 
output TIME16MS;
output TIME50U; 
output TIMEATT; 
output TIME130MS;
output TIME460MS;
output ATT_PULSE_HIGH;
output TIMEISPLUG;
output TIME_EN_1; 
output TIME_EN_2; 
output TIME_EN_3; 
output TIME_EN_4; 
output TIME_EN_5; 
output TIME_EN_6; 
output TIME60NS_L;
output TIME70NS_L;
output CTR_LFPS_RX; 
output CTR_SS_RX; 
output CTR_LFPS_TX; 
output CTR_SS_TX; 
output ATT_PULSE_LOW;
output TIME_HOLD_LOW;   
output CTR_IS_PLUG; 
output CTR_EN_LOW_IMP;
output CTR_VALID_ATT;
output CTR_TIMEOUT460;
output SEL_STATE;		
output SEL_PLUG_ATT;   	
output AGC_125U_EN;		    
output AGC_EN;			
output TIA_ZPSW;		
output BF_1EN;			
output BF_2EN;			
output BF_EN660;		
output BF_EN500;		
output BF_EN2;			
output LA_BIAS1;		
output LA_BIAS2;		
output LA_BIAS3;		
output LA_VREFA;		
output LA_VREF;		    
output reg123_wr;		
output reg95_wr;		
output MUX_GEN_V1P5; 	
output PTAT_IEQ;		
output reg97_wr;		
output reg98_wr;		
output reg102_wr;		
output reg103_wr;	
output reg104_wr;		
output reg105_wr;		
output reg106_wr;		
output reg107_wr;		
output reg108_wr;		
output reg109_wr;		
output reg110_wr;		
output LA_RD2;		
output LA_RD1;		
output LA_RD4;		
output LA_RD3;		
output LA_RD6;		
output LA_RD5;		
output reg114_wr;		
output reg115_wr;		
output BF_CMFB;	    
output BF_SRC;	
output reg117_wr;		
output reg118_wr;		
output BF_RD2;	
output BF_RD1;	
output reg120_wr;		    					
output reg124_wr;		
output reg125_wr;	

// define internal signal
// by rcm_simplified
wire sys_clk;
wire rst_n;
wire i2c_busy;
// connect rcm_simplified and memtop
wire i2c_active;
wire i2c_start;
wire i2c_stop;
wire i2c_wd_rst;
wire i2c_wd_en_n;
wire i2c_rst_n;
wire i2c_active_rst_n;
wire i2c_scl_rst_n;
wire i2c_stop_rst_n;
wire i2c_scl_clk;
wire i2c_scl_n_clk;
wire i2c_sda_clk;
wire i2c_sda_clk_n;
wire reg_file_clk_2_rcm;
// connect rcm_simplified and regfile
wire shadow_reg_clk;
// connect memtop and reg file
wire [6:0] xbus_addr;
wire [7:0] xbus_din;
wire [7:0] xbus_dout;
wire xbus_wr;
wire i_run_test_mode;
wire i_otp_read_n;
wire i_otp_prog;
wire reg_file_clk;
wire [6:0] i2c_addr;
wire i2c_wd_sel;

regfile regfile_i (
.rst_n 					(rst_n				),		
.sys_clk 				(sys_clk			),
.reg_file_clk 			(reg_file_clk		),	
.shadow_reg_clk 		(shadow_reg_clk		),
.xbus_addr 				(xbus_addr			),
.xbus_wr 				(xbus_wr			),
.xbus_din 				(xbus_din			),
.xbus_dout 				(xbus_dout			),
.clk_en 				(clk_en				),
.power_en 				(power_en			),
.i2c_wd_en_n 			(i2c_wd_en_n		),
.i2c_wd_sel				(i2c_wd_sel			),
.i2c_del				(i2c_del			),	// to i2c delay circuit
.soft_rst				(soft_rst			),	// to PoR reset circuit
.i2c_addr				(i2c_addr			),	// usb chip address, connect to memtop
.passcode				(passcode			),	// PHSGNX passcode	
.i_otp_prog				(i_otp_prog			),	// define program enable to access otp controller, active high
.i_otp_read_n			(i_otp_read_n		), 	// define read enable to access otp controller, active low
.i_run_test_mode		(i_run_test_mode	), 	// read only bit, check if users access test mode or not
.reg09_wr				(reg09_wr			),
.reg11_wr				(reg11_wr			),
.reg12_wr				(reg12_wr			),
.reg13_wr				(reg13_wr			),		
.reg14_wr				(reg14_wr			),
.reg15_wr				(reg15_wr			),
.reg16_wr				(reg16_wr			),
.LFPS_EN_CONTROLLER		(LFPS_EN_CONTROLLER	),
.reg18_wr				(reg18_wr			),
.reg19_wr				(reg19_wr			),
.reg20_wr				(reg20_wr			),
.reg21_wr				(reg21_wr			),
.reg22_wr				(reg22_wr			),
.reg23_wr				(reg23_wr			),
.reg24_wr				(reg24_wr			),
.reg25_wr				(reg25_wr			),
.reg26_wr				(reg26_wr			),
.reg27_wr				(reg27_wr			),
.reg28_wr				(reg28_wr			),
.EN_EMP					(EN_EMP				),
.TX_EN_CONTROLLER		(TX_EN_CONTROLLER	),
.reg30_wr				(reg30_wr			),
.reg31_wr				(reg31_wr			),
.reg32_wr				(reg32_wr			),
.reg33_wr				(reg33_wr			),
.reg34_wr				(reg34_wr			),
.reg35_wr				(reg35_wr			),
.reg36_wr				(reg36_wr			),	
.reg37_wr				(reg37_wr			),
.reg38_wr				(reg38_wr			),
.reg39_wr				(reg39_wr			),
.reg40_wr				(reg40_wr			),
.reg41_wr				(reg41_wr			),
.reg42_wr				(reg42_wr			),
.SYS_IMP_EN				(SYS_IMP_EN			),
.reg44_wr				(reg44_wr			),
.TIME100NS_OFF			(TIME100NS_OFF		),	
.EMP_VALUE_CTRL			(EMP_VALUE_CTRL		),
.LPMM_EN				(LPMM_EN			),
.TIME40NS 				(TIME40NS			),
.TIME100NS_ON   		(TIME100NS_ON		),
.TIME300NS 				(TIME300NS			),
.TIME60NS_H				(TIME60NS_H			),
.TIME70NS_H				(TIME70NS_H			),
.TIME200NS 				(TIME200NS			),
.TIME170NS 				(TIME170NS			),
.TIME1MS 				(TIME1MS			),
.TIME16MS				(TIME16MS			),
.TIME50U 				(TIME50U			),
.TIMEATT 				(TIMEATT			),
.TIME130MS				(TIME130MS			),
.TIME460MS				(TIME460MS			),
.ATT_PULSE_HIGH			(ATT_PULSE_HIGH		),
.TIMEISPLUG				(TIMEISPLUG			),
.TIME_EN_1 				(TIME_EN_1			),
.TIME_EN_2 				(TIME_EN_2			),
.TIME_EN_3 				(TIME_EN_3			),
.TIME_EN_4 				(TIME_EN_4			),
.TIME_EN_5 				(TIME_EN_5			),
.TIME_EN_6 				(TIME_EN_6			),
.TIME60NS_L				(TIME60NS_L			),
.TIME70NS_L				(TIME70NS_L			),
.CTR_LFPS_RX 			(CTR_LFPS_RX		),
.CTR_SS_RX				(CTR_SS_RX			),
.CTR_LFPS_TX			(CTR_LFPS_TX		),
.CTR_SS_TX				(CTR_SS_TX			),	
.ATT_PULSE_LOW			(ATT_PULSE_LOW		),
.TIME_HOLD_LOW			(TIME_HOLD_LOW		),
.CTR_IS_PLUG			(CTR_IS_PLUG		),
.CTR_EN_LOW_IMP			(CTR_EN_LOW_IMP		),
.CTR_VALID_ATT			(CTR_VALID_ATT		),
.CTR_TIMEOUT460			(CTR_TIMEOUT460		),
.SEL_STATE				(SEL_STATE			),
.SEL_PLUG_ATT			(SEL_PLUG_ATT		), 	
.TIA_ZPSW				(TIA_ZPSW			),
.AGC_125U_EN			(AGC_125U_EN		),
.AGC_EN					(AGC_EN				),						
.BF_1EN					(BF_1EN				),								
.BF_2EN					(BF_2EN				),								
.BF_EN660				(BF_EN660			),								
.BF_EN500				(BF_EN500			),							
.BF_EN2					(BF_EN2				),								
.LA_BIAS1				(LA_BIAS1			),								
.LA_BIAS2				(LA_BIAS2			),								
.LA_BIAS3				(LA_BIAS3			),								
.LA_VREFA				(LA_VREFA			),								
.LA_VREF				(LA_VREF			),									
.reg123_wr				(REG123_WR			),								
.reg95_wr				(REG95_WR			),								
.MUX_GEN_V1P5			(MUX_GEN_V1P5		),	
.PTAT_IEQ				(PTAT_IEQ			),												
.reg97_wr				(REG97_WR			),								
.reg98_wr				(REG98_WR			),																
.reg102_wr				(REG102_WR			),								
.reg103_wr				(REG103_WR			),								
.reg104_wr				(REG104_WR			),								
.reg105_wr				(REG105_WR			),								
.reg106_wr				(REG106_WR			),								
.reg107_wr				(REG107_WR			),								
.reg108_wr				(REG108_WR			),								
.reg109_wr				(REG109_WR			),								
.reg110_wr				(REG110_WR			),								
.LA_RD2					(LA_RD2				),							
.LA_RD1					(LA_RD1				),							
.LA_RD4					(LA_RD4				),						
.LA_RD3					(LA_RD3				),							
.LA_RD6					(LA_RD6				),						
.LA_RD5					(LA_RD5				),						
.reg114_wr				(REG114_WR			),								
.reg115_wr				(REG115_WR			),								
.BF_CMFB				(BF_CMFB			),						
.BF_SRC					(BF_SRC				),						
.reg117_wr				(REG117_WR			),								
.reg118_wr				(REG118_WR			),								
.BF_RD2					(BF_RD2				),						
.BF_RD1					(BF_RD1				),					
.reg120_wr				(REG120_WR			),																						
.reg124_wr				(REG124_WR			),								
.reg125_wr				(REG125_WR			)			
);

rcm_simplified rcm_simplified_i (
.xtal_clk					(xtal_clk				), 		// input crystal clock
.por_rst_n					(por_rst_n				),	 	// input POR reset
.hif_active					(i2c_active				), 		// Interface ACTIVE bit
.hif_start					(i2c_start				), 		// Interface START bit
.hif_stop					(i2c_stop				), 		// Interface STOP bit
.hif_scl					(hif_scl				), 		// Interface SCL signal
.hif_watchdog				(i2c_wd_rst				), 		// Watchdog interrupt
.hif_scl_del				(hif_scl_del			), 		// delay of SCL signal
.hif_sda_del				(hif_sda_del			), 		// delay of SDA signal
.slow_clk_in				(slow_clk_in			), 		// Slow clock from ring osc
.hif_select					(1'b0					), 		// Interface select signal
.hif_idle					(hif_idle_feedback		), 		// Signal indicating host interface idle
.i2c_wd_en_n				(i2c_wd_en_n			), 		// Enable I2C watchdog from register file
.i2c_rst_n					(i2c_rst_n				), 		// Reset I2C interface without I2C register address reg
.i2c_active_rst_n			(i2c_active_rst_n		), 		// Reset I2C register address reg
.i2c_scl_rst_n				(i2c_scl_rst_n			), 		// Reset START bit from scl signal
.i2c_stop_rst_n				(i2c_stop_rst_n			), 		// Reset ACTIVE bit from STOP bit and watchdog
.i2c_clk					(i2c_scl_clk			), 		// I2C clock
.i2c_clk_n					(i2c_scl_n_clk			), 		// I2C inverted clock
.reg_file_clk				(reg_file_clk_2_rcm		), 		// Register file clock
.i2c_sda_clk				(i2c_sda_clk			), 		// I2C clock using SDA signal for START, STOP, ACTIVE bit
.i2c_sda_clk_n				(i2c_sda_clk_n			), 		// I2C clock using inverted SDA signal
.slow_clk					(slow_clk				), 		// Slow clock for I2C watchdog
.sys_clk					(sys_clk				), 		// System clock 
.shadow_reg_clk				(shadow_reg_clk			), 		// clock for shadow register 
.slow_clk_en				(slow_clk_en			), 		// output enable signal for the ring oscillator 
.rst_n						(rst_n					)  		// System reset
);

memtop memtop_i (
.sys_clk 					(sys_clk				),
.rst_n						(rst_n					),
.xbus_addr					(xbus_addr				),
.xbus_din					(xbus_din				),
.xbus_dout					(xbus_dout				),
.xbus_wr					(xbus_wr				),
.i_run_test_mode			(i_run_test_mode		),
.i_otp_read_n				(i_otp_read_n			),
.i_otp_prog					(i_otp_prog				),
.reg_file_clk				(reg_file_clk 			),
.o_otp_vddqsw				(o_otp_vddqsw			),
.o_otp_csb					(o_otp_csb				),
.o_otp_strobe				(o_otp_strobe			),
.o_otp_load					(o_otp_load				),
.i_otp_q					(i_otp_q				),
.o_otp_addr					(o_otp_addr				),
.o_otp_pgenb				(o_otp_pgenb			),
.scan_en					(scan_en				),
.scan_clk					(scan_clk				),
.i2c_sda_clk				(i2c_sda_clk			),
.i2c_sda_n_clk				(i2c_sda_clk_n			),
.i2c_scl					(i2c_clk_after_del		),
.i2c_scl_reg				(reg_file_clk_2_rcm		),
.slow_clk					(slow_clk				),
.i2c_stop_rst_n				(i2c_stop_rst_n			),
.i2c_scl_rst_n				(i2c_scl_rst_n			),
.i2c_rst_n					(i2c_rst_n				),
.i2c_wd_en_n				(i2c_wd_en_n			),
.i2c_wd_sel					(i2c_wd_sel				),
.i2c_active					(i2c_active				),
.i2c_start					(i2c_start				),
.i2c_stop					(i2c_stop				),
.i2c_wd_rst					(i2c_wd_rst				),
.i2c_scl_clk				(i2c_scl_clk			),
.i2c_scl_n_clk				(i2c_scl_n_clk			),
.i2c_active_rst_n			(i2c_active_rst_n		),
.i2c_sda_i					(i2c_din_after_del		),
.i2c_sda_o					(i2c_dout_before_del	),
.m_i2c_addr					(i2c_addr				),
.i2c_addr_inv				(1'b0					),
.hif_idle					(hif_idle_out			),
.i2c_busy					(i2c_busy				)
);

test_mode_ctrl test_mode_ctrl_i (
.sys_clk					(sys_clk				),		//system clock, 200MHz clock generated by LO
.rst_n						(rst_n					),		//power on reset, active low
.i2c_busy					(i2c_busy				), 		//signaling that there is i2c transaction or not
.reg_passcode				(passcode				), 		//register is used to write passcode
.run_test_mode				(i_run_test_mode		) 		//signaling that test mode can be accessed 
);

io_ctrl io_ctrl_i (
.i2c_sda_i					(i2c_din_before_del		),		// output data for i2c interface (put this signal to i2c delay block)
.i2c_sda_o					(i2c_dout_after_del		),		// input data for i2c_interface (get this signal from i2c delay block)
.sdx_input					(sdx_input				), 		// input value for SDX pad
.sdx_output					(sdx_output				), 		// output to sdx pad
.sdx_output_en_n			(sdx_output_en_n		) 		// output enable signal for SDX pad
);


endmodule