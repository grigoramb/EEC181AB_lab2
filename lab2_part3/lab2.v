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
	wire [31:0]delay;
	wire [31:0] led;

	wire [7:0] H = 8'h76;
	wire [7:0] E = 8'h79;
	wire [7:0] L = 8'h38;
	wire [7:0] O = 8'h3f;
	wire [7:0] U = 8'h3e;
	wire [7:0] R = 8'h50;
	wire [7:0] D = 8'h5e;
	wire [7:0] space = 8'h0;
	
	wire [7:0] string[0:21];
	assign string[0] = space;
	assign string[1] = space;
	assign string[2] = space;
	assign string[3] = space;
	assign string[4] = space;
	assign string[5] = H;
	assign string[6] = E;
	assign string[7] = L;
	assign string[8] = L;
	assign string[9] = O;
	assign string[10] = space;
	assign string[11] = U;
	assign string[12] = U;
	assign string[13] = O;
	assign string[14] = R;
	assign string[15] = L;
	assign string[16] = D;
	assign string[17] = space;
	assign string[18] = space;
	assign string[19] = space;
	assign string[20] = space;
	assign string[21] = space;
	
	assign HEX5 = string[0];
	assign HEX4 = string[1];
	assign HEX3 = string[2];
	assign HEX2 = string[3];
	assign HEX1 = string[4];
	assign HEX0 = string[5];
	// CL
	reg [31:0] count;
	initial begin
		count = 0;
	end
	always @ (posedge CLOCK_50) begin
		if(count > delay) begin
			count <= 0;
			assign string <= {string[1:21], string[0]};
		end
		else begin
			count <= count + 1;
		end
	end
	// ^CL





	
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
        .to_hex_to_led_readdata (delay)//{LEDR[7:0],HEX5,HEX4,HEX3,HEX2,HEX1,HEX0})  //    to_hex_to_led.readdata
    );
endmodule
