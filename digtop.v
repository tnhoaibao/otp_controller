`timescale 1ns/10ps
module digtop (
	
);

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
.CTR_SS_RX			(CTR_SS_RX),
.CTR_LFPS_TX			(CTR_LFPS_TX),
.CTR_SS_TX			(CTR_SS_TX),	
.ATT_PULSE_LOW			(ATT_PULSE_LOW),
.TIME_HOLD_LOW			(TIME_HOLD_LOW),
.CTR_IS_PLUG			(CTR_IS_PLUG),
.CTR_EN_LOW_IMP			(CTR_EN_LOW_IMP),
.CTR_VALID_ATT			(CTR_VALID_ATT),
.CTR_TIMEOUT460			(CTR_TIMEOUT460),
.SEL_STATE			(SEL_STATE),
.SEL_PLUG_ATT			(SEL_PLUG_ATT), 	
.TIA_ZPSW			(TIA_ZPSW),
.AGC_125U_EN			(AGC_125U_EN),
.AGC_EN				(AGC_EN),						
.BF_1EN				(BF_1EN),								
.BF_2EN				(BF_2EN),								
.BF_EN660			(BF_EN660),								
.BF_EN500			(BF_EN500),							
.BF_EN2				(BF_EN2),								
.LA_BIAS1			(LA_BIAS1),								
.LA_BIAS2			(LA_BIAS2),								
.LA_BIAS3			(LA_BIAS3),								
.LA_VREFA			(LA_VREFA),								
.LA_VREF			(LA_VREF),									
.reg123_wr			(REG123_WR),								
.reg95_wr			(REG95_WR),								
.MUX_GEN_V1P5			(MUX_GEN_V1P5),	
.PTAT_IEQ			(PTAT_IEQ),												
.reg97_wr			(REG97_WR),								
.reg98_wr			(REG98_WR),																
.reg102_wr			(REG102_WR),								
.reg103_wr			(REG103_WR),								
.reg104_wr			(REG104_WR),								
.reg105_wr			(REG105_WR),								
.reg106_wr			(REG106_WR),								
.reg107_wr			(REG107_WR),								
.reg108_wr			(REG108_WR),								
.reg109_wr			(REG109_WR),								
.reg110_wr			(REG110_WR),								
.LA_RD2				(LA_RD2),//REG111							
.LA_RD1				(LA_RD1),//REG111							
.LA_RD4				(LA_RD4),//REG112							
.LA_RD3				(LA_RD3),//REG112							
.LA_RD6				(LA_RD6),//REG113							
.LA_RD5				(LA_RD5),//REG113							
.reg114_wr			(REG114_WR),								
.reg115_wr			(REG115_WR),								
.BF_CMFB			(BF_CMFB),//REG116								
.BF_SRC				(BF_SRC),//REG116							
.reg117_wr			(REG117_WR),								
.reg118_wr			(REG118_WR),								
.BF_RD2				(BF_RD2),//REG119							
.BF_RD1				(BF_RD1),//REG119							
.reg120_wr			(REG120_WR),																						
.reg124_wr			(REG124_WR),								
.reg125_wr			(REG125_WR)			
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
.rst_n						(rst_n					) // System reset
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
.i2c_sda_i					(i2c_sda_i				),
.i2c_sda_o					(i2c_sda_o				),
.m_i2c_addr					(i2c_addr				),
.i2c_addr_inv				(1'b0					),
.hif_idle					(hif_idle				)
);


endmodule