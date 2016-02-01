module lab2(
    // ************
	 //FPGA Pins
    // ************
    // Clock Pins
    CLOCK_50,
	 DRAM_CLK,
    
    // Seven Segment Displays
    HEX0,
    HEX1,
    HEX2,
    HEX3,
    HEX4,
    HEX5,
    
    // Pushbuttons
    KEY,
    
    // LEDs
    LEDR,
    
    // HPS Pins
    
    // DDR3_SDRAM
	 
    HPS_DDR3_ADDR,
    HPS_DDR3_BA,
    HPS_DDR3_CAS_N,
    HPS_DDR3_CKE,
    HPS_DDR3_CK_N,
    HPS_DDR3_CK_P,
    HPS_DDR3_CS_N,
    HPS_DDR3_DM,
    HPS_DDR3_DQ,
    HPS_DDR3_DQS_N,
    HPS_DDR3_DQS_P,
    HPS_DDR3_ODT,
    HPS_DDR3_RAS_N,
    HPS_DDR3_RESET_N,
    HPS_DDR3_RZQ,
    HPS_DDR3_WE_N
	 
);
	


    // ************************************
	// PORT declarations
    // ************************************

	
	// FPGA Pins
	//////////////////
	
	input CLOCK_50;
	output DRAM_CLK;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input [3:0] KEY;
	output [9:0] LEDR;
	
	
	// HPS Pins
	/////////////////
	
	// DDR3 SDRAM
	output [14:0] HPS_DDR3_ADDR;
	output [2:0] HPS_DDR3_BA;
	output HPS_DDR3_CAS_N;
	output HPS_DDR3_CKE;
	output HPS_DDR3_CK_N;
	output HPS_DDR3_CK_P;
	output HPS_DDR3_CS_N;
	output [3:0] HPS_DDR3_DM;
	inout [31:0] HPS_DDR3_DQ;
	inout [3:0] HPS_DDR3_DQS_N;
	inout [3:0] HPS_DDR3_DQS_P;
	output HPS_DDR3_ODT;
	output HPS_DDR3_RAS_N;
	output HPS_DDR3_RESET_N;
	input HPS_DDR3_RZQ;
	output HPS_DDR3_WE_N;

	
	// REG/WIRE declarations
	//////////////////////////////////
	wire [31:0]inputnum;
	wire [31:0] led;
		
	hex_7seg hex0 (inputnum[3:0],HEX0);
	hex_7seg hex1 (inputnum[7:4],HEX1);
	hex_7seg hex2 (inputnum[11:8],HEX2);
	hex_7seg hex3 (inputnum[15:12],HEX3);
	hex_7seg hex4 (inputnum[19:16],HEX4);
	hex_7seg hex5 (inputnum[23:20],HEX5);
	assign LEDR[7:0] = inputnum[31:24];
	
    mysystem u0 (
        .system_ref_clk_clk     (CLOCK_50),     			//   system_ref_clk.clk
        .system_ref_reset_reset (~KEY[0]), 					// system_ref_reset.reset
        .memory_mem_a       (HPS_DDR3_ADDR),       		//      memory.mem_a
        .memory_mem_ba      (HPS_DDR3_BA),      			//            .mem_ba
        .memory_mem_ck      (HPS_DDR3_CK_P),      			//            .mem_ck
        .memory_mem_ck_n    (HPS_DDR3_CK_N),    			//            .mem_ck_n
        .memory_mem_cke     (HPS_DDR3_CKE),     			//            .mem_cke
        .memory_mem_cs_n    (HPS_DDR3_CS_N),    			//            .mem_cs_n
        .memory_mem_ras_n   (HPS_DDR3_RAS_N),   			//            .mem_ras_n
        .memory_mem_cas_n   (HPS_DDR3_CAS_N),   			//            .mem_cas_n
        .memory_mem_we_n    (HPS_DDR3_WE_N),    			//            .mem_we_n
        .memory_mem_reset_n (HPS_DDR3_RESET_N), 			//            .mem_reset_n
        .memory_mem_dq      (HPS_DDR3_DQ),      			//            .mem_dq
        .memory_mem_dqs     (HPS_DDR3_DQS_P),     			//            .mem_dqs
        .memory_mem_dqs_n   (HPS_DDR3_DQS_N),   			//            .mem_dqs_n
        .memory_mem_odt     (HPS_DDR3_ODT),     			//            .mem_odt
        .memory_mem_dm      (HPS_DDR3_DM),      			//            .mem_dm
        .memory_oct_rzqin   (HPS_DDR3_RZQ),   				//            .oct_rzqin
        .pushbuttons_export (~KEY[3:1]),     				//      pushbuttons.export
        .sdram_clk_clk          (DRAM_CLK),       		   //        sdram_clk.clk
        .to_hex_to_led_readdata (inputnum)//{LEDR[7:0],HEX5,HEX4,HEX3,HEX2,HEX1,HEX0})  //    to_hex_to_led.readdata
    );
endmodule