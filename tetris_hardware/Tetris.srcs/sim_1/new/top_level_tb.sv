`include "tetris_define.vh"
module top_level_tb(); //even though the testbench doesn't create any hardware, it still needs to be a module

	timeunit 1ns;	// This is the amount of time represented by #1 
	timeprecision 1ns;

	// These signals are internal because the processor will be 
	// instantiated as a submodule in testbench.
	logic clk;
    logic reset;
    
    logic [9:0] drawX, drawY;
    logic [3:0] red, green, blue;
    logic [`PLAYFIELD_COL_WIDTH-1:0] col;
    logic [`PLAYFIELD_ROW_WIDTH-1:0] row;
    
    logic vsync;
    logic [`TETRIS_COLORS_NUM_WIDTH-1:0] playfield[`PLAYFIELD_ROW][`PLAYFIELD_COL];
    logic [2:0] game_state;
    logic [31:0] keycode0_gpio;
	// Instantiating the DUT (Device Under Test)
	// Make sure the module and signal names match with those in your design
	// Note that if you called the 8-bit version something besides 'Processor'
	// You will need to change the module name
    vga_controller vga (
        .pixel_clk(clk),
        .reset(reset),
        .hs(hsync),
        .vs(vsync),
        .active_nblank(vde),
        .drawX(drawX),
        .drawY(drawY)
    );	
    
    tetris_display tetris_display_instance(
        .Reset(reset), 
        .frame_clk(vsync),
        .keycode(keycode0_gpio[7:0]),
        .DrawX(drawX), 
        .DrawY(drawY),
        .Red(red),
        .Green(green),
        .Blue(blue)
    );
    
	initial begin: CLOCK_INITIALIZATION
		clk = 1;
	end 

	// Toggle the clock
	// #1 means wait for a delay of 1 timeunit, so simulation clock is 50 MHz technically 
	// half of what it is on the FPGA board 

	// Note: Since we do mostly behavioral simulations, timing is not accounted for in simulation, however
	// this is important because we need to know what the time scale is for how long to run
	// the simulation
	always begin : CLOCK_GENERATION
		#1 clk = ~clk;
	end
    
    assign col = tetris_display_instance.draw_left_playfield.col;
    assign row = tetris_display_instance.draw_left_playfield.row;
    assign playfield = tetris_display_instance.playfield;
    assign game_state = tetris_display_instance.tetris_game_inst.game_state;
	// Testing begins here
	// The initial block is not synthesizable on an FPGA
	// Everything happens sequentially inside an initial block
	// as in a software program

	// Note: Even though the testbench happens sequentially,
	// it is recommended to use non-blocking assignments for most assignments because
	// we do not want any dependencies to arise between different assignments in the 
	// same simulation timestep. The exception is for reset, which we want to make sure
	// happens first. 
	initial begin: TEST_VECTORS
	 
		reset <= 1;
		repeat (4) @(posedge clk);
		reset <= 0;
		repeat (4) @(posedge clk);
		// ----------- Test 1 ------------
		repeat (20) @(posedge clk);
		$finish(); //this task will end the simulation if the Vivado settings are properly configured


	end

endmodule

