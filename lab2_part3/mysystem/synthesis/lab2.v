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
	 
	 SW,
    
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
	input [9:0] SW;
	
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

	wire [7:0] H = ~(8'h76);
	wire [7:0] E = ~(8'h79);
	wire [7:0] L = ~(8'h38);
	wire [7:0] O = ~(8'h3f);
	wire [7:0] U = ~(8'h3e);
	wire [7:0] R = ~(8'h50);
	wire [7:0] D = ~(8'h5e);
	wire [7:0] space = ~(8'h0);
	
	reg [7:0] hello[0:16];
   reg [7:0] custom[0:6];
	
	reg pause;
	reg [2:1]prevkey; // KEY2 is toggle pattern, KEY1 is toggle pause
	reg pattern; // 0 is hello world, 1 is custom pattern
	
	assign reset = ~KEY[3];
	
	assign HEX5 = pattern ? custom[0] : hello[0];
	assign HEX4 = pattern ? custom[1] : hello[1];
	assign HEX3 = pattern ? custom[2] : hello[2];
	assign HEX2 = pattern ? custom[3] : hello[3];
	assign HEX1 = pattern ? custom[4] : hello[4];
	assign HEX0 = pattern ? custom[5] : hello[5];
	// CL
	reg [31:0] count;

	assign LEDR[9:0] = SW[9:0];
	
	integer i;
	
	always @ (posedge CLOCK_50) begin
		if(reset) begin
			count <= 0;
			hello[0] <= space;
			hello[1] <= space;
			hello[2] <= space;
			hello[3] <= space;
			hello[4] <= space;
			hello[5] <= H;
			hello[6] <= E;
			hello[7] <= L;
			hello[8] <= L;
			hello[9] <= O;
			hello[10] <= space;
			hello[11] <= U;
			hello[12] <= U;
			hello[13] <= O;
			hello[14] <= R;
			hello[15] <= L;
			hello[16] <= D;
			custom[0] <= space;
			custom[1] <= space;
			custom[2] <= space;
			custom[3] <= space;
			custom[4] <= space;
			custom[5] <= space;
			custom[6] <= space;
			pause <= 0;
			prevkey[1] <= KEY[1];
			prevkey[2] <= KEY[2];
			pattern <= 0; // hello world
		end
		else begin
		   prevkey[1] <= KEY[1];
			prevkey[2] <= KEY[2];
			pause <= prevkey[1] & ~KEY[1] ? ~pause : pause; // toggle when key 0->1
			if(prevkey[2] & ~KEY[2]) begin // toggling pattern key 0->1
				pattern <= ~pattern;    
				if(~pattern) begin // switching to custom
					custom[6] <= space;     // initially off screen
					custom[5] <= {1'b1,~SW[6:0]};    // right most display
					custom[4] <= {5'hF,~SW[9:7]};
					custom[3] <= space;
					custom[2] <= space;
					custom[1] <= space;
					custom[0] <= space;          // far left
				end
			end
			if((count > delay) && ~pause) begin
				count <= 0;
				for(i = 0; i < 17; i = i + 1) begin
					hello[i] <= hello[(i+1)%17];
				end 
				for(i = 0; i < 7; i = i + 1) begin
				   custom[i] <= custom[(i+1)%7];
				end
			end
			else begin
				count <= count + 1;
			end
		end
	end
	// ^CL


	// assign LEDR = delay;


	
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
