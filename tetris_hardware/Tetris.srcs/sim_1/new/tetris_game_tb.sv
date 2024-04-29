`include "tetris_define.vh"
module tetris_game_tb(); //even though the testbench doesn't create any hardware, it still needs to be a module

	timeunit 10ns;	// This is the amount of time represented by #1 
	timeprecision 1ns;

	// These signals are internal because the processor will be 
	// instantiated as a submodule in testbench.
	logic 		clk;
	logic		reset;
	logic [`TETRIS_COLORS_NUM_WIDTH-1:0] playfield[`PLAYFIELD_ROW][`PLAYFIELD_COL];
	logic [7:0]  keycode;
	
	logic [2:0] game_state;
    logic signed [`PLAYFIELD_ROW_WIDTH:0] block_y;
    logic check_move_done;
    logic move_valid;
	logic check_start;
	logic signed [1:0] move_y;
	logic [1:0] check_state;
	logic draw_block_en;
	block_move_t attempt_move;
	// Instantiating the DUT (Device Under Test)
	// Make sure the module and signal names match with those in your design
	// Note that if you called the 8-bit version something besides 'Processor'
	// You will need to change the module name
	tetris_game tetris_game_test(
	   .frame_clk(clk),
	   .Reset(reset),
	   .keycode(keycode),
	   .playfield(playfield)
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
    
    assign game_state = tetris_game_test.game_state;
    assign block_y = tetris_game_test.curr_block.y;
    assign check_move_done = tetris_game_test.check_move_done;
    assign move_valid = tetris_game_test.move_valid;
    assign check_start = tetris_game_test.check_start;
    assign move_y = tetris_game_test.move_y;
    assign check_state = tetris_game_test.check_move_inst.check_state;
    assign attempt_move = tetris_game_test.attempt_move;
//    assign draw_block_en_next = tetris_game_test.draw_block_en_next;
    assign draw_block_en = tetris_game_test.draw_block_en;
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
	    
	    reset <= 0;
	 
		reset <= 1;
		repeat (4) @(posedge clk);
		reset <= 0;
		repeat (4) @(posedge clk);
		// ----------- Test 1 ------------
		repeat (20) @(posedge clk);
		$finish(); //this task will end the simulation if the Vivado settings are properly configured


	end

endmodule

