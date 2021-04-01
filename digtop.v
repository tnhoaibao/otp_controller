`timescale 1ns/10ps
module digtop (
rst_n,				// input PoR reset
sys_clk,			// input 200MHz LO clock
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
i2c_din_after_del,	// input SDA, after i2c delay block
i2c_din_before_del, // output SDA, check if we can remove this signal
i2c_dout_after_del, // input SDA output, after i2c delay
i2c_dout_before_del,// output SDA output, check if we can remove this signal
clk_en,				// output enable 200MHz LO clock
i2c_del,			// output, trimming delay timing of i2c delay	
reg05_wr,			// output, contains read/program enable for otp controller
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

input rst_n,				// input PoR reset
input sys_clk,			// input 200MHz LO clock
output soft_rst,			// output soft reset, go to PoR generator block
input hif_scl,			// input SCL, connect to SCL signal directly
input hif_scl_del,		// input SCL, connect to SCL delay signal after I2C delay block
input hif_sda_del,		// input SDA, connect to SDA delay signal after i2c delay block
input slow_clk_in,		// input slow clock from ring oscillator
output slow_clk_en,		// output enable signal for the slow ring oscillator 
input sdx_input,			// input SDA, connect to SDA signal from SDA pad
output sdx_output,			// output SDA, connect to SDA (output pin) pad
output sdx_output_en_n,	// output enable signal for SDA pad
output hif_idle_out,		// output HIF IDLE, send out hif_idle signal before feedback to use as clock
input hif_idle_feedback,	// input HIF_IDLE, hif_dile feedback signal
input i2c_din_after_del,	// input SDA, after i2c delay block
output i2c_din_before_del, // output SDA, check if we can remove this signal
input i2c_dout_after_del, // input SDA output, after i2c delay
output i2c_dout_before_del,// output SDA output, check if we can remove this signal
output clk_en,				// output enable 200MHz LO clock
output [3:0] i2c_del,			// output, trimming delay timing of i2c delay	
output [7:0] reg05_wr,			// output, contains read/program enable for otp controller
// output, trimming analog/digital circuits
// connect to corresponding circuits directly
input reg04_exam;		
input reg09_wr;		
input reg11_wr;		
input reg12_wr;	
input reg13_wr;	
input reg14_wr;	
input reg15_wr;	
input reg16_wr;	
input LFPS_EN_CONTROLLER;	
input reg18_wr;		
input reg19_wr;		
input reg20_wr;		
input reg21_wr;		
input reg22_wr;		
input reg23_wr;		
input reg24_wr;		
input reg25_wr;		
input reg26_wr;		
input reg27_wr;		
input reg28_wr;		
input EN_EMP;
input TX_EN_CONTROLLER;
input reg30_wr;		
input reg31_wr;		
input reg32_wr;		
input reg33_wr;		
input reg34_wr;		
input reg35_wr;		
input reg36_wr;		
input reg37_wr;		
input reg38_wr;		
input reg39_wr;		
input reg40_wr;		
input reg41_wr;		
input reg42_wr;		
input SYS_IMP_EN;	
input reg44_wr;		
input TIME100NS_OFF;	
input EMP_VALUE_CTRL;	
input LPMM_EN;
input TIME40NS; 
input TIME100NS_ON;   	
input TIME300NS; 
input TIME60NS_H;
input TIME70NS_H;
input TIME200NS; 
input TIME170NS; 
input TIME1MS; 
input TIME16MS;
input TIME50U; 
input TIMEATT; 
input TIME130MS;
input TIME460MS;
input ATT_PULSE_HIGH;
input TIMEISPLUG;
input TIME_EN_1; 
input TIME_EN_2; 
input TIME_EN_3; 
input TIME_EN_4; 
input TIME_EN_5; 
input TIME_EN_6; 
input TIME60NS_L;
input TIME70NS_L;
input CTR_LFPS_RX; 
input CTR_SS_RX; 
input CTR_LFPS_TX; 
input CTR_SS_TX; 
input ATT_PULSE_LOW;
input TIME_HOLD_LOW;   
input CTR_IS_PLUG; 
input CTR_EN_LOW_IMP;
input CTR_VALID_ATT;
input CTR_TIMEOUT460;
input SEL_STATE;		
input SEL_PLUG_ATT;   	
input AGC_125U_EN;		    
input AGC_EN;			
input TIA_ZPSW;		
input BF_1EN;			
input BF_2EN;			
input BF_EN660;		
input BF_EN500;		
input BF_EN2;			
input LA_BIAS1;		
input LA_BIAS2;		
input LA_BIAS3;		
input LA_VREFA;		
input LA_VREF;		    
input reg123_wr;		
input reg95_wr;		
input MUX_GEN_V1P5; 	
input PTAT_IEQ;		
input reg97_wr;		
input reg98_wr;		
input reg102_wr;		
input reg103_wr;	
input reg104_wr;		
input reg105_wr;		
input reg106_wr;		
input reg107_wr;		
input reg108_wr;		
input reg109_wr;		
input reg110_wr;		
input LA_RD2;		
input LA_RD1;		
input LA_RD4;		
input LA_RD3;		
input LA_RD6;		
input LA_RD5;		
input reg114_wr;		
input reg115_wr;		
input BF_CMFB;	    
input BF_SRC;	
input reg117_wr;		
input reg118_wr;		
input BF_RD2;	
input BF_RD1;	
input reg120_wr;		    					
input reg124_wr;		
input reg125_wr;	

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
.reg05_wr				(reg05_wr			),	// define program and read enable to access otp controller	
.reg04_exam				(reg04_exam			),
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
.xtal_clk					(xtal_clk				), // input crystal clock
.por_rst_n					(por_rst_n				), // input POR reset
.hif_active					(i2c_active				), // Interface ACTIVE bit
.hif_start					(i2c_start				), // Interface START bit
.hif_stop					(i2c_stop				), // Interface STOP bit
.hif_scl					(hif_scl				), // Interface SCL signal
.hif_watchdog				(i2c_wd_rst				), // Watchdog interrupt
.hif_scl_del				(hif_scl_del			), // delay of SCL signal
.hif_sda_del				(hif_sda_del			), // delay of SDA signal
.slow_clk_in				(slow_clk_in			), // Slow clock from ring osc
.hif_select					(1'b0					), // Interface select signal
.hif_idle					(hif_idle_feedback		), // Signal indicating host interface idle
.i2c_wd_en_n				(i2c_wd_en_n			), // Enable I2C watchdog from register file
.i2c_rst_n					(i2c_rst_n				), // Reset I2C interface without I2C register address reg
.i2c_active_rst_n			(i2c_active_rst_n		), // Reset I2C register address reg
.i2c_scl_rst_n				(i2c_scl_rst_n			), // Reset START bit from scl signal
.i2c_stop_rst_n				(i2c_stop_rst_n			), // Reset ACTIVE bit from STOP bit and watchdog
.i2c_clk					(i2c_scl_clk			), // I2C clock
.i2c_clk_n					(i2c_scl_n_clk			), // I2C inverted clock
.reg_file_clk				(reg_file_clk_2_rcm		), // Register file clock
.i2c_sda_clk				(i2c_sda_clk			), // I2C clock using SDA signal for START, STOP, ACTIVE bit
.i2c_sda_clk_n				(i2c_sda_clk_n			), // I2C clock using inverted SDA signal
.slow_clk					(slow_clk				), // Slow clock for I2C watchdog
.sys_clk					(sys_clk				), // System clock 
.shadow_reg_clk				(shadow_reg_clk			), // clock for shadow register 
.slow_clk_en				(slow_clk_en			), // output enable signal for the ring oscillator 
.rst_n						(rst_n					)  // System reset
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
.i2c_scl					(reg_file_clk_2_rcm		),		//check, need to share i2c_scl and reg_file_clk
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
.hif_idle					(hif_idle_out			)
);

io_ctrl io_ctrl_i (
.i2c_sda_i					(i2c_din_before_del		),		// input data for i2c interface (put this signal to i2c delay block)
.i2c_sda_o					(i2c_dout_after_del		),		// output data for i2c_interface (put this signal to i2c delay block)
.sdx_input					(sdx_input				), 		// input value for SDX pad
.sdx_output					(sdx_output				), 		// output to sdx pad
.sdx_output_en_n			(sdx_output_en_n		) 		// output enable signal for SDX pad
);


endmodule