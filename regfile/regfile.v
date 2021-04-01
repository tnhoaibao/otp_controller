`timescale 1ns/10ps
module regfile (
  rst_n, 			// reset signal
  sys_clk, 			// system clock signal
  reg_file_clk, 	// register clock synchronized with interface clock
  shadow_reg_clk, 	// shadow register clock synchronized with hif idle
  // from apb mux, choose either otp_controller or i2c interface
  xbus_addr, 		// address bus to access register file
  xbus_wr, 			// write signal to access register file
  xbus_din, 		// input data bus to access register file
  xbus_dout, 		// output data bus to access register file 
  clk_en, 			// Output enable crystal clock
  power_en, 		// Output enable LDO
  i2c_wd_en_n, 		// config bit for i2c watchdog
  i2c_wd_sel,
  i2c_del,
  soft_rst,
  i2c_addr,
  // register connect to analog/digital circuits
  passcode,			// PHSGNX passcode, used as a password to access test mode
  i_otp_read_n,		// config read enable for otp controller, active low
  i_otp_prog,		// config write enable for otp controller, active high
  i_run_test_mode,	// read only bit, check if users access test mode or not
  reg09_wr,			///
  reg11_wr,			///
  reg12_wr, //ADD		////
  reg13_wr,//ADD		////
  reg14_wr,//ADD		////
  reg15_wr,//ADD		////
  reg16_wr,//ADD		////
  LFPS_EN_CONTROLLER,	//REG17	/////
  reg18_wr,			/////
  reg19_wr,			/////
  reg20_wr,			/////
  reg21_wr,			/////
  reg22_wr,			/////
  reg23_wr,			/////
  reg24_wr,			/////
  reg25_wr,			/////
  reg26_wr,			/////
  reg27_wr,			/////
  reg28_wr,			/////
  EN_EMP,//REG42, ENABLE PRE-EMPHASIS	/////
  TX_EN_CONTROLLER, //REG29		/////
  reg30_wr,				/////
  reg31_wr,				/////
  reg32_wr,				/////
  reg33_wr,				/////
  reg34_wr,				/////
  reg35_wr,				/////
  reg36_wr,				/////
  reg37_wr,				/////
  reg38_wr,				/////
  reg39_wr,				/////
  reg40_wr,				/////
  reg41_wr,				/////
  reg42_wr,				/////
  SYS_IMP_EN,//REG29			/////	
  reg44_wr,								///
  TIME100NS_OFF,//REG45							///
  EMP_VALUE_CTRL,//REG46						///
  LPMM_EN,//REG46							///
  TIME40NS, //REG46							///
  TIME100NS_ON, //REG47							///		
  TIME300NS, //REG48							///
  TIME60NS_H,//REG49 							///
  TIME70NS_H,//REG50							///
  TIME200NS, //REG51							///
  TIME170NS, //REG52							///
  TIME1MS, //REG53,REG54,REG55						///
  TIME16MS, //REG56,REG57,REG58						///
  TIME50U, //REG59,REG60						///
  TIMEATT, //REG61,REG62						///
  TIME130MS,//REG63,REG64,REG65,REG66					///
  TIME460MS,//REG67,REG68,REG69,REG70					///
  ATT_PULSE_HIGH,//REG71,REG72						///
  TIMEISPLUG,//REG73,REG74,REG75					///
  TIME_EN_1, //Timer 1 to on/off circuits in LPMM,REG76,REG77		///
  TIME_EN_2, //Timer 2,REG78,REG79					///
  TIME_EN_3, //Timer 3,REG80,REG81					///
  TIME_EN_4, //Timer 4,REG82,REG83 					///
  TIME_EN_5, //Timer 5,REG84,REG85					///
  TIME_EN_6, //Timer 6,REG86,REG87					///
  TIME60NS_L,//REG88							///
  TIME70NS_L,//REG89							///
  CTR_LFPS_RX, //REG90							///
  CTR_SS_RX, //REG90							///
  CTR_LFPS_TX, //REG90							///
  CTR_SS_TX, //REG90							///
  ATT_PULSE_LOW,//REG91,REG92						///
  TIME_HOLD_LOW,//REG93,REG94						///	
  CTR_IS_PLUG, //REG70 ,TEST CHIP					///
  CTR_EN_LOW_IMP, //REG70, TEST CHIP					///
  CTR_VALID_ATT,//REG70, TEST CHIP					///
  CTR_TIMEOUT460, //REG70, TEST CHIP	
  SEL_STATE,								///
  SEL_PLUG_ATT,   							///
  AGC_125U_EN,								///	
  AGC_EN,								///
  TIA_ZPSW,								///
  BF_1EN,								///
  BF_2EN,								///
  BF_EN660,								///
  BF_EN500,								///
  BF_EN2,								///
  LA_BIAS1,								///
  LA_BIAS2,								///
  LA_BIAS3,								///
  LA_VREFA,								///
  LA_VREF,								///	
  reg123_wr,								///
  reg95_wr,								///
  MUX_GEN_V1P5, //REG96	
  PTAT_IEQ,								///
  reg97_wr,								///
  reg98_wr,								///
  reg102_wr,								///
  reg103_wr,								///
  reg104_wr,								///
  reg105_wr,								///
  reg106_wr,								///
  reg107_wr,								///
  reg108_wr,								///
  reg109_wr,								///
  reg110_wr,								///
  LA_RD2,//REG111							///
  LA_RD1,//REG111							///
  LA_RD4,//REG112							///
  LA_RD3,//REG112							///
  LA_RD6,//REG113							///
  LA_RD5,//REG113							///
  reg114_wr,								///
  reg115_wr,								///
  BF_CMFB,//REG116							///	
  BF_SRC,//REG116							///
  reg117_wr,								///
  reg118_wr,								///
  BF_RD2,//REG119							///
  BF_RD1,//REG119							///
  reg120_wr,								///						
  reg124_wr,								///
  reg125_wr								///
  );
  
//////////I2C//////////////////////////////
	input rst_n;			///
	input sys_clk;			///
	input reg_file_clk;		///
	input shadow_reg_clk;		///
	input [6:0] xbus_addr;		///
	input xbus_wr;			///
	input [7:0] xbus_din;		///
	output [7:0] xbus_dout;		///
	output clk_en;			///
	output power_en;		///			///
	output i2c_wd_en_n;		///
	output i2c_wd_sel;		///
	output [3:0] i2c_del;		///
	output soft_rst;		///
	output [6:0] i2c_addr;		///
	output [7:0] passcode;		///
	output i_otp_prog;
	output i_otp_read_n;
	input i_run_test_mode;
//////////////////OSC//////////////////////
	output [7:0] reg09_wr;		///
	output [3:0] reg11_wr;		///
////////////////LDO////////////////////////
  	output [5:0] reg12_wr; //ADD 	///
  	output [4:0] reg13_wr;//ADD	///
  	output [4:0] reg14_wr;//ADD	///
  	output [4:0] reg15_wr;//ADD	///
  	output [4:0] reg16_wr;//ADD	///
////////////////DETECTOR///////////////////////////////////////////
	output [4:0] LFPS_EN_CONTROLLER;//ON/OFF DETECTORS,LPMM ///
   	output [7:0] reg18_wr;					///
  	output [7:0] reg19_wr;					///
  	output [7:0] reg20_wr;					///
  	output [7:0] reg21_wr;					///
  	output [7:0] reg22_wr;					///
  	output [4:0] reg23_wr;					///
  	output [6:0] reg24_wr;					///
  	output [4:0] reg25_wr;					///
  	output [7:0] reg26_wr;					///
  	output [5:0] reg27_wr;					///
  	output [7:0] reg28_wr;					///
/////////////////////////////TX////////////////////////////////////
	output EN_EMP; //ENABLE PRE_EMPHASIS,REG42		///
	output [6:0] TX_EN_CONTROLLER;//REG29			///	
  	output [5:0] reg30_wr;					///
  	output [5:0] reg31_wr;					///
  	output [4:0] reg32_wr;					///
  	output [5:0] reg33_wr;					///
  	output [5:0] reg34_wr;					///
  	output [7:0] reg35_wr;					///
  	output [7:0] reg36_wr;					///
  	output [4:0] reg37_wr;					///
  	output [6:0] reg38_wr;					///
  	output [7:0] reg39_wr;					///
  	output [6:0] reg40_wr;					///
	output [6:0] reg41_wr;					///
	output [4:0] reg42_wr;					///
	output SYS_IMP_EN;//REG29				///
/////////////////////////////DIGITAL///////////////////////////////
  	output [5:0] reg44_wr;					///
	output [5:0] TIME100NS_OFF;				///
	output EMP_VALUE_CTRL;					///
	output	LPMM_EN;					///
	output [4:0] TIME40NS;					///
	output [5:0] TIME100NS_ON;				///
	output [6:0] TIME300NS;					///
	output [5:0] TIME60NS_H;				///
	output [5:0] TIME70NS_H;				///
	output [6:0] TIME200NS;					///
	output [6:0] TIME170NS;					///
	output [18:0] TIME1MS;					///
	output [22:0] TIME16MS;					///
	output [15:0] TIME50U;					///
	output [15:0] TIMEATT;					///
	output [26:0] TIME130MS;				///
	output [27:0] TIME460MS;				///
	output [15:0] ATT_PULSE_HIGH;				///
	output [22:0] TIMEISPLUG;				///
	output [15:0] TIME_EN_1;				///
	output [15:0] TIME_EN_2;				///
	output [15:0] TIME_EN_3;				///
	output [15:0] TIME_EN_4;				///
	output [15:0] TIME_EN_5;				///
	output [15:0] TIME_EN_6;				///
	output [5:0] TIME60NS_L;				///
	output [5:0] TIME70NS_L;				///
	output [1:0]  CTR_LFPS_RX;				///
	output [1:0]  CTR_SS_RX;				///
	output [1:0]  CTR_LFPS_TX;				///
	output [1:0]  CTR_SS_TX;				///
	output [15:0] ATT_PULSE_LOW;				///
	output [12:0] TIME_HOLD_LOW;				///
	output	CTR_IS_PLUG;					///
	output	CTR_EN_LOW_IMP;					///
	output	CTR_VALID_ATT;					///
	output	CTR_TIMEOUT460;					///
	output [1:0] SEL_STATE;					///
	output [2:0] SEL_PLUG_ATT;				///
/////////////////////////RX///////////////////////////////////////
	output TIA_ZPSW;					//
	output AGC_125U_EN;					//
	output AGC_EN;						//
	output BF_1EN;						//
	output BF_2EN;						//
	output BF_EN660;					//
	output BF_EN500;					//
	output BF_EN2;						//
	output LA_BIAS1;					//
	output LA_BIAS2;					//
	output LA_BIAS3;					//
	output LA_VREFA;					//
	output LA_VREF;						//
	output [5:0] reg123_wr;					//
  	output [5:0] reg95_wr;					//
  	output [3:0] MUX_GEN_V1P5;//REG96
	output [2:0] PTAT_IEQ;					//
  	output [2:0] reg97_wr;					//
  	output [4:0] reg98_wr;					//
  	output [5:0] reg102_wr;					//
  	output [4:0] reg103_wr;					//
  	output [4:0] reg104_wr;					//
  	output [4:0] reg105_wr;					//
  	output [4:0] reg106_wr;					//
  	output [5:0] reg107_wr;					//
  	output [5:0] reg108_wr;					//
  	output [5:0] reg109_wr;					//
	output [6:0] reg110_wr;					//
	output [2:0] LA_RD2;					//
	output [2:0] LA_RD1;					//
	output [2:0] LA_RD4;					//
	output [2:0] LA_RD3;					//
	output [2:0] LA_RD6;					//
	output [2:0] LA_RD5;					//								
	output [4:0] reg114_wr;					//
	output [4:0] reg115_wr;					//
  	output [1:0] BF_CMFB;					//
	output [2:0] BF_SRC;					//
	output [5:0] reg117_wr;					//
  	output [5:0] reg118_wr;					//
	output [2:0] BF_RD2;					//
	output [2:0] BF_RD1;					//
	output [3:0] reg120_wr;					//																		
	output [1:0] reg124_wr;					//
	output [6:0] reg125_wr;					//
								
	wire [6:0] i2c_addr;
	wire [3:0] i2c_del;
	wire clk_en;
	reg power_en;
	wire [6:0] xbus_addr;
	wire [7:0] xbus_din;
	reg [7:0] xbus_dout;
	reg [6:0] power_en_counter_r;
	reg clk_en_temp;
	reg clk_en_temp_sync1, clk_en_temp_sync2, clk_en_temp_sync3;
	reg power_gate_r;


	wire [7:0] reg_00;
	wire [7:0] reg_01;
	wire [7:0] reg_02;
	wire [7:0] reg_03;
	reg [6:0] reg_04;
	reg [7:0] reg_05;
	reg [7:0] reg_06;
	reg [7:0] reg_07;
	reg [7:0] reg_08;
	reg [7:0] reg_09;
	reg [7:0] reg_10;
	reg [7:0] reg_11;			// Read only
	reg [7:0] reg_12;
	reg [7:0] reg_13;
	reg [7:0] reg_14;
	reg [7:0] reg_15;
	reg [7:0] reg_16;
	reg [7:0] reg_17;
	reg [7:0] reg_18;
	reg [7:0] reg_19;
	reg [7:0] reg_20;
	reg [7:0] reg_21;
	reg [7:0] reg_22;
	reg [7:0] reg_23;
	reg [7:0] reg_24;
	reg [7:0] reg_25;
	reg [7:0] reg_26;
	reg [7:0] reg_27;
	reg [7:0] reg_28;
	reg [7:0] reg_29;
	reg [7:0] reg_30;
	reg [7:0] reg_31;
	reg [7:0] reg_32;
	reg [7:0] reg_33;
	reg [7:0] reg_34;
	reg [7:0] reg_35;
	reg [7:0] reg_36;
	reg [7:0] reg_37;
	reg [7:0] reg_38;
	reg [7:0] reg_39;
	reg [7:0] reg_40;
	reg [7:0] reg_41;
	reg [7:0] reg_42;
	reg [7:0] reg_43;
	reg [7:0] reg_44;
	reg [7:0] reg_45;
	reg [7:0] reg_46;
	reg [7:0] reg_47;
	reg [7:0] reg_48;
	reg [7:0] reg_49;
	reg [7:0] reg_50;
	reg [7:0] reg_51;
	reg [7:0] reg_52;
	reg [7:0] reg_53;
	reg [7:0] reg_54;
	reg [7:0] reg_55;
	reg [7:0] reg_56;
	reg [7:0] reg_57;
	reg [7:0] reg_58;
	reg [7:0] reg_59;
	reg [7:0] reg_60;
	reg [7:0] reg_61;
	reg [7:0] reg_62;
	reg [7:0] reg_63;	
	reg [7:0] reg_64;	
	reg [7:0] reg_65;
	reg [7:0] reg_66;
	reg [7:0] reg_67;
	reg [7:0] reg_68;
	reg [7:0] reg_69;
	reg [7:0] reg_70;	
	reg [7:0] reg_71;	
	reg [7:0] reg_72;
	reg [7:0] reg_73;	
	reg [7:0] reg_74;	
	reg [7:0] reg_75;	
	reg [7:0] reg_76;	
	reg [7:0] reg_77;
	reg [7:0] reg_78;
	reg [7:0] reg_79;
	reg [7:0] reg_80;
	reg [7:0] reg_81;
	reg [7:0] reg_82;	
	reg [7:0] reg_83;	
	reg [7:0] reg_84;	
	reg [7:0] reg_85;	
	reg [7:0] reg_86;
	reg [7:0] reg_87;
	reg [7:0] reg_88;
	reg [7:0] reg_89;
	reg [7:0] reg_90;
	reg [7:0] reg_91;
	reg [7:0] reg_92;
	reg [7:0] reg_93;
	reg [7:0] reg_94;
	reg [7:0] reg_95;
	reg [7:0] reg_96;
	reg [7:0] reg_97;
	reg [7:0] reg_98;
	reg [7:0] reg_99;
	reg [7:0] reg_100;
	reg [7:0] reg_101;
	reg [7:0] reg_102;
	reg [7:0] reg_103;
	reg [7:0] reg_104;
	reg [7:0] reg_105;
	reg [7:0] reg_106;
	reg [7:0] reg_107;
	reg [7:0] reg_108;
	reg [7:0] reg_109;	
	reg [7:0] reg_110;	
	reg [7:0] reg_111;
	reg [7:0] reg_112;
 	reg [7:0] reg_113;
	reg [7:0] reg_114;
	reg [7:0] reg_115;
	reg [7:0] reg_116;
	reg [7:0] reg_117;
	reg [7:0] reg_118;
	reg [7:0] reg_119;			
	reg [7:0] reg_120;
	reg [7:0] reg_121;
	reg [7:0] reg_122;
	reg [7:0] reg_123;
	reg [7:0] reg_124;
	reg [7:0] reg_125;
	reg [7:0] reg_126;	//dummy
	reg soft_rst;

  // define for CHIP ID
  assign reg_00 = 8'h50;
  assign reg_01 = 8'h53;
  assign reg_02 = 8'h56;
  assign reg_03 = 8'h32;

  always @ (posedge reg_file_clk or negedge rst_n)
    begin
      if (rst_n == 1'b0)
        begin
          reg_04 <= 7'h10;//PREVIOUS:4'h80
          reg_05 <= 8'h00;
          reg_06 <= 8'h00;
          reg_07 <= 8'h00;
      	  reg_08 <= 8'h0A;
          reg_09 <= 8'h78;
          reg_10 <= 8'h00;		  
		  reg_11 <= 8'h08;
          reg_12 <= 8'h30;
          reg_13 <= 8'h0F;
          reg_14 <= 8'h10;
          reg_15 <= 8'h0F;
          reg_16 <= 8'h18;
          reg_17 <= 8'h0F;
          reg_18 <= 8'h77;
          reg_19 <= 8'hB4;
          reg_20 <= 8'h90;
          reg_21 <= 8'hB4;
          reg_22 <= 8'h90;
          reg_23 <= 8'h1B;
          reg_24 <= 8'h5A;
          reg_25 <= 8'h1B;
		  reg_26 <= 8'h83;
		  reg_27 <= 8'h07;
          reg_28 <= 8'h88;
          reg_29 <= 8'hFF;
          reg_30 <= 8'h0F;
          reg_31 <= 8'h0C;
          reg_32 <= 8'h0D;	
          reg_33 <= 8'h12;
          reg_34 <= 8'h1B;
          reg_35 <= 8'h70;
          reg_36 <= 8'h70;	
          reg_37 <= 8'h10;	   
          reg_38 <= 8'h78;
		  reg_39 <= 8'h88;
		  reg_40 <= 8'h5C;
          reg_41 <= 8'h4C;
          reg_42 <= 8'h30;
		  reg_43 <= 8'h00;
          reg_44 <= 8'h1C;	
          reg_45 <= 8'h2B;
          reg_46 <= 8'h07;
          reg_47 <= 8'h27;
          reg_48 <= 8'h33;
          reg_49 <= 8'h08;
		  reg_50 <= 8'h02;
          reg_51 <= 8'h0C;	
          reg_52 <= 8'h0B;	
          reg_53 <= 8'h7F;	
          reg_54 <= 8'h1A;
          reg_55 <= 8'h06;	
          reg_56 <= 8'hFF;	
          reg_57 <= 8'hD3;	
          reg_58 <= 8'h30;	
          reg_59 <= 8'h10;
          reg_60 <= 8'h27;
          reg_61 <= 8'hF8;	
          reg_62 <= 8'h2A;
          reg_63 <= 8'h7F;
          reg_64 <= 8'hBA;
          reg_65 <= 8'h8C;
          reg_66 <= 8'h01;	
          reg_67 <= 8'hFF;	
          reg_68 <= 8'hCE;	
          reg_69 <= 8'h7B;	
          reg_70 <= 8'h05; 
          reg_71 <= 8'hF0;
          reg_72 <= 8'h55;
		  reg_73 <= 8'h40;	
          reg_74 <= 8'hE1;
          reg_75 <= 8'h33;	
          reg_76 <= 8'h63;
          reg_77 <= 8'h00;
		  reg_78 <= 8'hC7;
		  reg_79 <= 8'h00;
		  reg_80 <= 8'h2B;
		  reg_81 <= 8'h01;
		  reg_82 <= 8'h8F;	
		  reg_83 <= 8'h01;
		  reg_84 <= 8'hF3;
		  reg_85 <= 8'h01;	
		  reg_86 <= 8'h57;	
          reg_87 <= 8'h02;	
          reg_88 <= 8'h0D;	
          reg_89 <= 8'h02;
		  reg_90 <= 8'h33;	
          reg_91 <= 8'hA0;
          reg_92 <= 8'h0F;
          reg_93 <= 8'hD0;
		  reg_94 <= 8'h07;
          reg_95 <= 8'h19;
          reg_96 <= 8'h49;
          reg_97 <= 8'h03;
          reg_98 <= 8'h11;
		  reg_99 <= 8'h33;
          reg_100 <= 8'h28;
          reg_101 <= 8'h04;
		  reg_102 <= 8'h17;	
		  reg_103 <= 8'h00;	
		  reg_104 <= 8'h10;
		  reg_105 <= 8'h11;
		  reg_106 <= 8'h13;
		  reg_107 <= 8'h1B;
		  reg_108 <= 8'h1B;
		  reg_109 <= 8'h3F;
		  reg_110 <= 8'h7F;
		  reg_111 <= 8'h44;
		  reg_112 <= 8'h44;
          reg_113 <= 8'h44;
		  reg_114 <= 8'h30;
          reg_115 <= 8'h30;
		  reg_116 <= 8'h33;
          reg_117 <= 8'h22;
		  reg_118 <= 8'h27;
		  reg_119 <= 8'h34;
		  reg_120 <= 8'h0D;
		  reg_121 <= 8'hFF;
		  reg_122 <= 8'hFF;
		  reg_123 <= 8'hFF;
		  reg_124 <= 8'h03;
		  reg_125 <= 8'h77;
		  reg_126 <= 8'h00;
	    end
      else
        if (xbus_wr == 1'b1)
          case (xbus_addr)
            4: reg_04 <= xbus_din[6:0];
            5: reg_05 <= xbus_din;
            6: reg_06 <= xbus_din;
            7: reg_07 <= xbus_din;
            8: reg_08 <= xbus_din;
            9: reg_09 <= xbus_din;
            10: reg_10 <= xbus_din;
			11: reg_11 <= xbus_din;
            12: reg_12 <= xbus_din;
            13: reg_13 <= xbus_din;
            14: reg_14 <= xbus_din;
            15: reg_15 <= xbus_din;
            16: reg_16 <= xbus_din;
            17: reg_17 <= xbus_din;
            18: reg_18 <= xbus_din;
            19: reg_19 <= xbus_din;
            20: reg_20 <= xbus_din;
            21: reg_21 <= xbus_din;
            22: reg_22 <= xbus_din;
            23: reg_23 <= xbus_din;
            24: reg_24 <= xbus_din;
			25: reg_25 <= xbus_din;
			26: reg_26 <= xbus_din;
            27: reg_27 <= xbus_din;
            28: reg_28 <= xbus_din;
            29: reg_29 <= xbus_din;
            30: reg_30 <= xbus_din;
            31: reg_31 <= xbus_din;
            32: reg_32 <= xbus_din;
            33: reg_33 <= xbus_din;
            34: reg_34 <= xbus_din;
            35: reg_35 <= xbus_din;
            36: reg_36 <= xbus_din;
            37: reg_37 <= xbus_din;
            38: reg_38 <= xbus_din;
            39: reg_39 <= xbus_din;
            40: reg_40 <= xbus_din;
            41: reg_41 <= xbus_din;
            42: reg_42 <= xbus_din;
            43: reg_43 <= xbus_din;
            44: reg_44 <= xbus_din;
            45: reg_45 <= xbus_din;
            46: reg_46 <= xbus_din;
            47: reg_47 <= xbus_din;
            48: reg_48 <= xbus_din;
            49: reg_49 <= xbus_din;
            50: reg_50 <= xbus_din;
            51: reg_51 <= xbus_din;
            52: reg_52 <= xbus_din;
            53: reg_53 <= xbus_din;
            54: reg_54 <= xbus_din;
            55: reg_55 <= xbus_din;
			56: reg_56 <= xbus_din;
            57: reg_57 <= xbus_din;
            58: reg_58 <= xbus_din;
            59: reg_59 <= xbus_din;
            60: reg_60 <= xbus_din;
            61: reg_61 <= xbus_din;
            62: reg_62 <= xbus_din;
            63: reg_63 <= xbus_din;
            64: reg_64 <= xbus_din;
            65: reg_65 <= xbus_din;
            66: reg_66 <= xbus_din;
            67: reg_67 <= xbus_din;
            68: reg_68 <= xbus_din;
            69: reg_69 <= xbus_din;
            70: reg_70 <= xbus_din;
            71: reg_71 <= xbus_din;
			72: reg_72 <= xbus_din;
			73: reg_73 <= xbus_din;
			74: reg_74 <= xbus_din;
            75: reg_75 <= xbus_din;
            76: reg_76 <= xbus_din;
            77: reg_77 <= xbus_din;
            78: reg_78 <= xbus_din;
            79: reg_79 <= xbus_din;
            80: reg_80 <= xbus_din;
            81: reg_81 <= xbus_din;
            82: reg_82 <= xbus_din;
            83: reg_83 <= xbus_din;
            84: reg_84 <= xbus_din;
            85: reg_85 <= xbus_din;
            86: reg_86 <= xbus_din;
            87: reg_87 <= xbus_din;
            88: reg_88 <= xbus_din;
            89: reg_89 <= xbus_din;
            90: reg_90 <= xbus_din;
            91: reg_91 <= xbus_din;
            92: reg_92 <= xbus_din;
            93: reg_93 <= xbus_din;
            94: reg_94 <= xbus_din;
            95: reg_95 <= xbus_din;
            96: reg_96 <= xbus_din;
            97: reg_97 <= xbus_din;
            98: reg_98 <= xbus_din;
            99: reg_99 <= xbus_din;
            100: reg_100 <= xbus_din;
            101: reg_101 <= xbus_din;
			102: reg_102 <= xbus_din;
			103: reg_103 <= xbus_din;
			104: reg_104 <= xbus_din;
			105: reg_105 <= xbus_din;
			106: reg_106 <= xbus_din;
			107: reg_107 <= xbus_din;
			108: reg_108 <= xbus_din;
			109: reg_109 <= xbus_din;
			110: reg_110 <= xbus_din;
			111: reg_111 <= xbus_din;
			112: reg_112 <= xbus_din;
			113: reg_113 <= xbus_din;
			114: reg_114 <= xbus_din;
			115: reg_115 <= xbus_din;
			116: reg_116 <= xbus_din;
			117: reg_117 <= xbus_din;
			118: reg_118 <= xbus_din;
			119: reg_119 <= xbus_din;
			120: reg_120 <= xbus_din;
			121: reg_121 <= xbus_din;
			122: reg_122 <= xbus_din;
			123: reg_123 <= xbus_din;
			124: reg_124 <= xbus_din;
			125: reg_125 <= xbus_din;
			126: reg_126 <= xbus_din;
          endcase
    end

  // Read process
  always @ (*)
    case (xbus_addr)
      0: xbus_dout = reg_00;
      1: xbus_dout = reg_01;
      2: xbus_dout = reg_02;
      3: xbus_dout = reg_03;
      4: xbus_dout = {i_run_test_mode, reg_04};
      5: xbus_dout = reg_05;
      6: xbus_dout = reg_06;
      7: xbus_dout = reg_07;
      8: xbus_dout = reg_08;
      9: xbus_dout = reg_09;
      10: xbus_dout = reg_10;
      11: xbus_dout = reg_11;
      12: xbus_dout = reg_12;
      13: xbus_dout = reg_13;
      14: xbus_dout = reg_14;
      15: xbus_dout = reg_15;
      16: xbus_dout = reg_16;
      17: xbus_dout = reg_17;
      18: xbus_dout = reg_18;
      19: xbus_dout = reg_19;
      20: xbus_dout = reg_20;
      21: xbus_dout = reg_21;
      22: xbus_dout = reg_22;
      23: xbus_dout = reg_23;
      24: xbus_dout = reg_24;
      25: xbus_dout = reg_25;
      26: xbus_dout = reg_26;
      27: xbus_dout = reg_27;
      28: xbus_dout = reg_28;
      29: xbus_dout = reg_29;
      30: xbus_dout = reg_30;
      31: xbus_dout = reg_31;
      32: xbus_dout = reg_32;
      33: xbus_dout = reg_33;
      34: xbus_dout = reg_34;
      35: xbus_dout = reg_35;
      36: xbus_dout = reg_36;
      37: xbus_dout = reg_37;
      38: xbus_dout = reg_38;
      39: xbus_dout = reg_39;
      40: xbus_dout = reg_40;
      41: xbus_dout = reg_41;
      42: xbus_dout = reg_42;
      43: xbus_dout = reg_43;
      44: xbus_dout = reg_44;
      45: xbus_dout = reg_45;
      46: xbus_dout = reg_46;
      47: xbus_dout = reg_47;
      48: xbus_dout = reg_48;
      49: xbus_dout = reg_49;
      50: xbus_dout = reg_50;
      51: xbus_dout = reg_51;
      52: xbus_dout = reg_52;
      53: xbus_dout = reg_53;
      54: xbus_dout = reg_54;
      55: xbus_dout = reg_55;
      56: xbus_dout = reg_56;
      57: xbus_dout = reg_57;
      58: xbus_dout = reg_58;
      59: xbus_dout = reg_59;
      60: xbus_dout = reg_60;
      61: xbus_dout = reg_61;
      62: xbus_dout = reg_62;
      63: xbus_dout = reg_63;
      64: xbus_dout = reg_64;
      65: xbus_dout = reg_65;
      66: xbus_dout = reg_66;
      67: xbus_dout = reg_67;
      68: xbus_dout = reg_68;
      69: xbus_dout = reg_69;
      70: xbus_dout = reg_70;
      71: xbus_dout = reg_71;
      72: xbus_dout = reg_72;
      73: xbus_dout = reg_73;
      74: xbus_dout = reg_74;
      75: xbus_dout = reg_75;
      76: xbus_dout = reg_76;
      77: xbus_dout = reg_77;
      78: xbus_dout = reg_78;
      79: xbus_dout = reg_79;
      80: xbus_dout = reg_80;
      81: xbus_dout = reg_81;
      82: xbus_dout = reg_82;
      83: xbus_dout = reg_83;
      84: xbus_dout = reg_84;
      85: xbus_dout = reg_85;
      86: xbus_dout = reg_86;
      87: xbus_dout = reg_87;
      88: xbus_dout = reg_88;
      89: xbus_dout = reg_89;
      90: xbus_dout = reg_90;
      91: xbus_dout = reg_91;
      92: xbus_dout = reg_92;
      93: xbus_dout = reg_93;
      94: xbus_dout = reg_94;
      95: xbus_dout = reg_95;
      96: xbus_dout = reg_96;
      97: xbus_dout = reg_97;
      98: xbus_dout = reg_98;
      99: xbus_dout = reg_99;
      100: xbus_dout = reg_100;
      101: xbus_dout = reg_101;
      102: xbus_dout = reg_102;
      103: xbus_dout = reg_103;
      104: xbus_dout = reg_104;
      105: xbus_dout = reg_105;
      106: xbus_dout = reg_106;
      107: xbus_dout = reg_107;
      108: xbus_dout = reg_108;
      109: xbus_dout = reg_109;
      110: xbus_dout = reg_110;
      111: xbus_dout = reg_111;
      112: xbus_dout = reg_112;
      113: xbus_dout = reg_113;
      114: xbus_dout = reg_114;
      115: xbus_dout = reg_115;
      116: xbus_dout = reg_116;
      117: xbus_dout = reg_117;
      118: xbus_dout = reg_118;
      119: xbus_dout = reg_119; 	
      120: xbus_dout = reg_120;
      121: xbus_dout = reg_121;
      122: xbus_dout = reg_122;
      123: xbus_dout = reg_123;
      124: xbus_dout = reg_124;
      125: xbus_dout = reg_125;
      126: xbus_dout = reg_126;
      default: xbus_dout = 8'h00;
    endcase
    
	// shadow_reg_clock used for shadow FFs, 
	// signals in this block will be changed after finishing i2c transaction
    always @ (posedge shadow_reg_clk or negedge rst_n)
	begin
      if (rst_n == 1'b0)
	    begin
	      clk_en_temp <= 1'b1;
		  soft_rst <= 1'b0;
	    end
      else
	    begin
	      if ((reg_04[1:0] == 2'b00) || (reg_04[1:0] == 2'b11)) clk_en_temp <= 1'b1;
	      else clk_en_temp <= 1'b0;
		  soft_rst <= reg_07[0] & reg_07[1];
	    end
	end   
	
	// synchronized clock_en signal with sys_clk
	always @ (posedge sys_clk or negedge rst_n)
	begin
	  if (rst_n == 1'b0)
		begin
		  clk_en_temp_sync1 <= 1'b1;
		  clk_en_temp_sync2 <= 1'b1;
		  clk_en_temp_sync3 <= 1'b1;
		end
	  else
		begin
		  clk_en_temp_sync1 <= clk_en_temp;
		  clk_en_temp_sync2 <= clk_en_temp_sync1;
		  clk_en_temp_sync3 <= clk_en_temp_sync2;
		end
	end		
	
	always @ (posedge sys_clk or negedge rst_n)
	begin
	  if (rst_n == 1'b0)
		begin
		  power_en <= 1'b1;
		  power_en_counter_r <= 7'h7F;
		  power_gate_r <= 1'b1;
		end
	  else
		begin
		  power_en <= clk_en_temp_sync2;
		  if (clk_en_temp_sync2 == 1'b0) power_en_counter_r <= 7'h00;
		  else if (power_en_counter_r != 7'b1100000) power_en_counter_r <= power_en_counter_r + 1;
		  if (clk_en_temp_sync2 == 1'b0) power_gate_r <= 1'b0;
		  else if (power_en_counter_r[6:5] == 2'b11) power_gate_r <= 1'b1;
		end
	end
	
	assign clk_en = clk_en_temp_sync3 | clk_en_temp;	
	assign i2c_wd_en_n = reg_06[7];
	assign i2c_wd_sel = reg_06[6];
	assign i2c_del = reg_07[7:4];
	assign i2c_addr = reg_08[6:0];
	assign passcode = (power_gate_r == 1'b1)? reg_05[7:0] : 8'h00;
	assign i_otp_prog = (power_gate_r == 1'b1) ? reg_04 [5] : 1'b0;
	assign i_otp_read_n = (power_gate_r == 1'b1) ? reg_04[4] : 1'b0;

///////////////////////////////////OSC//////////////////////////////////////////////////////////
	assign reg09_wr = (power_gate_r == 1'b1)? reg_09[7:0] : 8'h00;			////////
	assign reg11_wr = (power_gate_r == 1'b1)? reg_11[3:0] : 4'h0; 			////////
////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////LDO/////////////////////////////////////////////////////////////
												//
	assign reg12_wr = (power_gate_r == 1'b1)? reg_12[5:0] : 6'h00;				//
	assign reg13_wr = (power_gate_r == 1'b1)? reg_13[4:0] : 5'h00;				//
	assign reg14_wr = (power_gate_r == 1'b1)? reg_14[4:0] : 5'h00;				//
	assign reg15_wr = (power_gate_r == 1'b1)? reg_15[4:0] : 5'h00;				//
	assign reg16_wr = (power_gate_r == 1'b1)? reg_16[4:0] : 5'h00;				//
	//assign reg121_wr = (power_gate_r == 1'b1)? reg_121[5:0] : 6'h00;			//
	//assign reg122_wr = (power_gate_r == 1'b1)? reg_122[4:0] : 5'h00;			//
//////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////DETECTOR//////////////////////////////////////////////////////////////////	
	assign LFPS_EN_CONTROLLER = (power_gate_r == 1'b1)? reg_17[4:0] : 5'b00000; //ON/OFF DETECTORS	//
	assign reg18_wr = (power_gate_r == 1'b1)? reg_18[7:0] : 8'h00;					//
	assign reg19_wr = (power_gate_r == 1'b1)? reg_19[7:0] : 8'h00;					//
	assign reg20_wr = (power_gate_r == 1'b1)? reg_20[7:0] : 8'h00;					//
	assign reg21_wr = (power_gate_r == 1'b1)? reg_21[7:0] : 8'h00;					//
	assign reg22_wr = (power_gate_r == 1'b1)? reg_22[7:0] : 8'h00;					//
	assign reg23_wr = (power_gate_r == 1'b1)? reg_23[4:0] : 5'h00;					//
	assign reg24_wr = (power_gate_r == 1'b1)? reg_24[6:0] : 7'h00;					//
	assign reg25_wr = (power_gate_r == 1'b1)? reg_25[4:0] : 5'h00;					//
	assign reg26_wr = (power_gate_r == 1'b1)? reg_26[7:0] : 8'h00;					//
	assign reg27_wr = (power_gate_r == 1'b1)? reg_27[5:0] : 6'h00;					//
	assign reg28_wr = (power_gate_r == 1'b1)? reg_28[7:0] : 8'h00;					//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////TX////////////////////////////////////////////////////////////
	assign EN_EMP = (power_gate_r == 1'b1)? reg_42[5] : 1'b0;			//////
	assign TX_EN_CONTROLLER = (power_gate_r == 1'b1)? reg_29[6:0] : 7'b0000000;	//////
	assign reg30_wr = (power_gate_r == 1'b1)? reg_30[5:0] : 6'h00;			//////
	assign reg31_wr = (power_gate_r == 1'b1)? reg_31[5:0] : 6'h00;			//////
	assign reg32_wr = (power_gate_r == 1'b1)? reg_32[4:0] : 5'h00;			//////
	assign reg33_wr = (power_gate_r == 1'b1)? reg_33[5:0] : 6'h00;			//////
	assign reg34_wr = (power_gate_r == 1'b1)? reg_34[5:0] : 6'h00;			//////
	assign reg35_wr = (power_gate_r == 1'b1)? reg_35[7:0] : 8'h00;			//////
	assign reg36_wr = (power_gate_r == 1'b1)? reg_36[7:0] : 8'h00;			//////
	assign reg37_wr = (power_gate_r == 1'b1)? reg_37[4:0] : 5'h00;			//////
	assign reg38_wr = (power_gate_r == 1'b1)? reg_38[6:0] : 7'h00;			//////
	assign reg39_wr = (power_gate_r == 1'b1)? reg_39[7:0] : 8'h00;			//////
	assign reg40_wr = (power_gate_r == 1'b1)? reg_40[6:0] : 7'h00;			//////
	assign reg41_wr = (power_gate_r == 1'b1)? reg_41[6:0] : 7'h00;			//////
	assign reg42_wr = (power_gate_r == 1'b1)? reg_42[4:0] : 5'h00;			//////
	//assign reg43_wr = (power_gate_r == 1'b1)? reg_43[7:0] : 8'h00;		//////
	assign SYS_IMP_EN = (power_gate_r == 1'b1)? reg_29[7] : 1'b0;			//////
//	assign reg121_wr = (power_gate_r == 1'b1)? reg_121[4:0] : 5'h00;		//////				
//	assign reg122_wr = (power_gate_r == 1'b1)? reg_122[6:0] : 7'h00;		//////
//	assign reg123_wr = (power_gate_r == 1'b1)? reg_123[6:0] : 7'h00;		//////
	//assign reg124_wr = (power_gate_r == 1'b1)? reg_124[3:0] : 4'h0;		//////
//////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////DIGITAL/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	assign reg44_wr = (power_gate_r == 1'b1)? reg_44[5:0] : 6'h00;														///////
	assign TIME100NS_OFF = (power_gate_r == 1'b1)? reg_45[5:0] :6'h00;													///////
	assign EMP_VALUE_CTRL = (power_gate_r == 1'b1)? reg_46[6] : 1'b0;													///////
	assign LPMM_EN = (power_gate_r == 1'b1)? reg_46[5] : 1'b0;														///////
	assign TIME40NS = (power_gate_r == 1'b1)? reg_46[4:0] : 5'h00;														///////
	assign TIME100NS_ON = (power_gate_r == 1'b1)? reg_47[5:0] : 6'h00;													///////
	assign TIME300NS = (power_gate_r == 1'b1)? reg_48[6:0] : 7'h00;														///////
	assign TIME60NS_H = (power_gate_r == 1'b1)? reg_49[5:0] : 6'h00;													///////
	assign TIME70NS_H = (power_gate_r == 1'b1)? reg_50[5:0] : 6'h00;													///////
	assign TIME200NS = (power_gate_r == 1'b1)? reg_51[6:0] : 7'h00;														///////
	assign TIME170NS = (power_gate_r == 1'b1)? reg_52[6:0] : 7'h00;														///////
	assign TIME1MS = (power_gate_r == 1'b1)? {reg_55[2:0],reg_54[7:0], reg_53[7:0]} : 19'h00000;										///////
	assign TIME16MS = (power_gate_r == 1'b1)? {reg_58[6:0], reg_57[7:0], reg_56[7:0]} : 23'h000000;										///////
	assign TIME50U = (power_gate_r == 1'b1)? {reg_60[7:0],  reg_59[7:0]} : 16'h0000;											///////
	assign TIMEATT = (power_gate_r == 1'b1)? {reg_62[7:0], reg_61[7:0]} : 16'h0000;												///////
	assign TIME130MS = (power_gate_r == 1'b1)? {reg_66[2:0], reg_65[7:0], reg_64[7:0], reg_63[7:0]} : 27'h0000000;								///////
	assign TIME460MS = (power_gate_r == 1'b1)? {reg_70[3:0],reg_69[7:0],reg_68[7:0],reg_67[7:0]} : 28'h0000000;								///////
	assign ATT_PULSE_HIGH  = (power_gate_r == 1'b1)? {reg_72[7:0],reg_71[7:0]} : 16'h0000;//add										///////
	assign TIMEISPLUG = (power_gate_r == 1'b1)? {reg_75[6:0], reg_74[7:0], reg_73[7:0]} : 23'h000000;									///////
	assign TIME_EN_1 = (power_gate_r == 1'b1)? {reg_77[7:0],reg_76[7:0]} : 16'h0000;											///////
	assign TIME_EN_2 = (power_gate_r == 1'b1)? {reg_79[7:0],reg_78[7:0]} : 16'h0000;											///////
	assign TIME_EN_3 = (power_gate_r == 1'b1)? {reg_81[7:0],reg_80[7:0]} : 16'h0000;											///////
	assign TIME_EN_4 = (power_gate_r == 1'b1)? {reg_83[7:0],reg_82[7:0]} : 16'h0000;											///////
	assign TIME_EN_5 = (power_gate_r == 1'b1)? {reg_85[7:0],reg_84[7:0]} : 16'h0000;											///////
	assign TIME_EN_6 = (power_gate_r == 1'b1)? {reg_87[7:0],reg_86[7:0]} : 16'h0000;											///////
	assign TIME60NS_L = (power_gate_r == 1'b1)? reg_88[5:0] : 6'h00;													///////
	assign TIME70NS_L = (power_gate_r == 1'b1)? reg_89[5:0] : 6'h00;													///////
	//Controlling the operation of TX_DECISION and RX_DECISION														///////				
	assign CTR_LFPS_RX = (power_gate_r == 1'b1)? reg_90[3:2] : 2'b00;													///////
	assign CTR_SS_RX = (power_gate_r == 1'b1)? reg_90[1:0] : 2'b00;														///////
	assign CTR_LFPS_TX = (power_gate_r == 1'b1)? reg_90[7:6] : 2'b00;													///////
	assign CTR_SS_TX = (power_gate_r == 1'b1)? reg_90[5:4] : 2'b00;														///////
	assign ATT_PULSE_LOW   = (power_gate_r == 1'b1)? {reg_92[7:0],reg_91[7:0]} : 16'h0000;//add										///////
	assign TIME_HOLD_LOW   = (power_gate_r == 1'b1)? {reg_94[4:0],reg_93[7:0]} : 13'h0000;//add										///////
	//TEST LPMM 																				///////
	assign CTR_IS_PLUG = (power_gate_r == 1'b1)? reg_70[7] : 1'b0;														///////
	assign CTR_EN_LOW_IMP = (power_gate_r == 1'b1)? reg_70[6] : 1'b0;													///////
	assign CTR_VALID_ATT = (power_gate_r == 1'b1)? reg_70[5] : 1'b0;													///////
	assign CTR_TIMEOUT460 = (power_gate_r == 1'b1)? reg_70[4] : 1'b0;
	assign SEL_STATE = (power_gate_r == 1'b1)? reg_66[7:6] : 2'b00;														///////						
	assign SEL_PLUG_ATT = (power_gate_r == 1'b1)? reg_66[5:3] : 3'b000;

																						///////
																						///////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////RX///////////////////////////////////////////
	assign TIA_ZPSW = (power_gate_r == 1'b1)? reg_121[0] : 1'b0;				/////
	assign AGC_125U_EN = (power_gate_r == 1'b1)? reg_121[7] : 1'b0;				/////
	assign AGC_EN = (power_gate_r == 1'b1)? reg_121[6] : 1'b0;				/////
	//SW ON/OFF										/////
	assign BF_1EN = (power_gate_r == 1'b1)? reg_122[7] : 1'b0;				/////
	assign BF_2EN = (power_gate_r == 1'b1)? reg_122[6] : 1'b0;				/////
	assign BF_EN660 = (power_gate_r == 1'b1)? reg_122[5] : 1'b0;				/////
	assign BF_EN500 = (power_gate_r == 1'b1)? reg_122[4] : 1'b0;				/////
	assign BF_EN2 = (power_gate_r == 1'b1)? reg_122[3] : 1'b0;				/////
	assign LA_BIAS1 = (power_gate_r == 1'b1)? reg_122[2] : 1'b0;				/////
	assign LA_BIAS2 = (power_gate_r == 1'b1)? reg_122[1] : 1'b0;				/////
	assign LA_BIAS3 = (power_gate_r == 1'b1)? reg_122[0] : 1'b0;				/////
	assign LA_VREFA = (power_gate_r == 1'b1)? reg_123[1] : 1'b0;				/////
	assign LA_VREF = (power_gate_r == 1'b1)? reg_123[0] : 1'b0;				/////
	assign reg123_wr = (power_gate_r == 1'b1)? reg_123[7:2] : 6'h00;			/////
	assign reg95_wr = (power_gate_r == 1'b1)? reg_95[5:0] : 6'h00;				/////
	assign MUX_GEN_V1P5 = (power_gate_r == 1'b1)? reg_96[3:0] : 4'h0;			/////
	assign PTAT_IEQ = (power_gate_r == 1'b1)? reg_96[6:4] : 3'h0;				/////
	//assign PVT_ITRIM = (power_gate_r == 1'b1)? reg_96[2:0] : 3'b000;			/////
	assign reg97_wr = (power_gate_r == 1'b1)? reg_97[2:0] : 3'b000;				/////
	assign reg98_wr = (power_gate_r == 1'b1)? reg_98[4:0] : 5'h00;				/////
	//assign AGC_TRIM_MAXTIA = (power_gate_r == 1'b1)? reg_99[6:4] : 3'b000;		/////
	//assign AGC_TRIM_MAXEQ = (power_gate_r == 1'b1)? reg_99[2:0] : 3'b000;			/////
	//assign reg100_wr = (power_gate_r == 1'b1)? reg_100[5:0] : 6'h00;			/////
	//assign reg101_wr = (power_gate_r == 1'b1)? reg_101[2:0] : 3'b000;			/////
	assign reg102_wr = (power_gate_r == 1'b1)? reg_102[5:0] : 6'h00;			/////
	assign reg103_wr = (power_gate_r == 1'b1)? reg_103[4:0] : 5'h00;			/////
	assign reg104_wr = (power_gate_r == 1'b1)? reg_104[4:0] : 5'h00;			/////
	assign reg105_wr = (power_gate_r == 1'b1)? reg_105[4:0] : 5'h00;			/////
	assign reg106_wr = (power_gate_r == 1'b1)? reg_106[4:0] : 5'h00;			/////
	assign reg107_wr = (power_gate_r == 1'b1)? reg_107[5:0] : 6'h00;			/////
	assign reg108_wr = (power_gate_r == 1'b1)? reg_108[5:0] : 6'h00;			/////
	assign reg109_wr = (power_gate_r == 1'b1)? reg_109[5:0] : 6'h00;			/////
	assign reg110_wr = (power_gate_r == 1'b1)? reg_110[6:0] : 7'h00;			/////
	assign LA_RD2 = (power_gate_r == 1'b1)? reg_111[6:4] : 3'b000;				/////
	assign LA_RD1 = (power_gate_r == 1'b1)? reg_111[2:0] : 3'b000;				/////
	assign LA_RD4 = (power_gate_r == 1'b1)? reg_112[6:4] : 3'b000;				/////
	assign LA_RD3 = (power_gate_r == 1'b1)? reg_112[2:0] : 3'b000;				/////
	assign LA_RD6 = (power_gate_r == 1'b1)? reg_113[6:4] : 3'b000;				/////
	assign LA_RD5 = (power_gate_r == 1'b1)? reg_113[2:0] : 3'b000;				/////
	assign reg114_wr = (power_gate_r == 1'b1)? reg_114[4:0] : 5'h00;			/////
	assign reg115_wr = (power_gate_r == 1'b1)? reg_115[4:0] : 5'h00;			/////
	assign BF_CMFB = (power_gate_r == 1'b1)? reg_116[5:4] : 2'b00;				/////
	assign BF_SRC = (power_gate_r == 1'b1)? reg_116[2:0] : 3'b000;				/////
	assign reg117_wr = (power_gate_r == 1'b1)? reg_117[5:0] : 6'h00;			/////
	assign reg118_wr = (power_gate_r == 1'b1)? reg_118[5:0] : 6'h00;			/////
	assign BF_RD2 = (power_gate_r == 1'b1)? reg_119[6:4] : 3'b000;				/////
	assign BF_RD1 = (power_gate_r == 1'b1)? reg_119[2:0] : 3'b000;				/////
	assign reg120_wr = (power_gate_r == 1'b1)? reg_120[3:0] : 4'h0;				/////
												/////
	assign reg124_wr = (power_gate_r == 1'b1)? reg_124[1:0] : 2'b00;			/////
	assign reg125_wr = (power_gate_r == 1'b1)? reg_125[6:0] : 7'h00;			/////
												/////
/////////////////////////////////////////////////////////////////////////////////////////////////////

endmodule