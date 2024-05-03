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
	
	
	logic [3:0] game_state;
	logic gen_next_block_en;
	block_info_t generated_block, curr_block;
	
    block_move_t attempt_move;
    logic check_start;
    logic [1:0] check_state;
    logic signed [1:0] move_x;
    logic signed [1:0] move_y;
    logic [1:0] attempt_point;
    logic check_move_done;
    logic move_valid;
	
//	logic signed [1:0] move_y;
//	logic [1:0] check_state;
//	logic draw_block_en;

	
	logic game_start;
	logic game_restart;
	logic [2:0] garbage_input;
	logic garbage_added;
	logic [15:0] score;
	logic game_over;
	logic garbage_output_valid;
	logic [2:0] garbage_output;
	logic  [`PLAYFIELD_ROW-1:0] full_row;
	logic [15:0] score;
	// Instantiating the DUT (Device Under Test)
	// Make sure the module and signal names match with those in your design
	// Note that if you called the 8-bit version something besides 'Processor'
	// You will need to change the module name
	tetris_game tetris_game_test(
	    .Reset(reset),
        .frame_clk(clk),
        .keycode(keycode),
        .game_start(game_start),
        .game_restart(game_restart),
        .garbage_input(garbage_input),
        .garbage_added(garbage_added),
        .playfield(playfield),
        .score(score),
        .game_over(game_over),
        .garbage_output_valid(garbage_output_valid),
        .garbage_output(garbage_output)
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
//    assign block_y = tetris_game_test.curr_block.y;
    assign check_move_done = tetris_game_test.check_move_done;
    assign move_valid = tetris_game_test.move_valid;
    assign check_start = tetris_game_test.check_start;
//    assign move_y = tetris_game_test.move_y;
//    assign check_state = tetris_game_test.check_move_inst.check_state;
    assign attempt_move = tetris_game_test.attempt_move;
    assign gen_next_block_en = tetris_game_test.gen_next_block_en;
    assign generated_block = tetris_game_test.generated_block;
    assign curr_block = tetris_game_test.curr_block;
    assign check_state = tetris_game_test.check_move_inst.check_state;
    assign move_x = tetris_game_test.check_move_inst.move_x;
    assign move_y = tetris_game_test.check_move_inst.move_y;
    assign attempt_point = tetris_game_test.check_move_inst.attempt_point;
//    assign draw_block_en_next = tetris_game_test.draw_block_en_next;
//    assign draw_block_en = tetris_game_test.draw_block_en;
//    assign full_row = tetris_game_test.full_row;
//    assign score = tetris_game_test.score;
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
		
		game_start <= 1;
		game_restart <= 0;
		garbage_input <= 0;
		repeat (4) @(posedge clk);
		game_start <= 0;
		// ----------- Test 1 ------------
		
//		keycode <= `NEW_GAME_1;
//		repeat (20) @(posedge clk);
//		keycode <= 0;
		repeat (20) @(posedge clk);
//		// move first block to 0
        keycode <= 0;
        repeat (2) @(posedge clk);
		keycode <= `MOVE_ROTATE_1;
		repeat (4) @(posedge clk);
		keycode <= 0;
		repeat (1) @(posedge clk);
		keycode <= `MOVE_LEFT_1;
		repeat (4) @(posedge clk);
		keycode <= 0;
		repeat (1) @(posedge clk);
		keycode <= `MOVE_LEFT_1;
		repeat (4) @(posedge clk);
		keycode <= 0;
		repeat (1) @(posedge clk);
		keycode <= `MOVE_LEFT_1;
		repeat (4) @(posedge clk);
		keycode <= 0;
		repeat (1) @(posedge clk);
		keycode <= `MOVE_LEFT_1;
		repeat (4) @(posedge clk);
		keycode <= 0;
		repeat (1) @(posedge clk);
		keycode <= `MOVE_LEFT_1;
		repeat (4) @(posedge clk);
		keycode <= 0;
		repeat (1) @(posedge clk);
		keycode <= `MOVE_LEFT_1;
		repeat (4) @(posedge clk);
		keycode <= 0;
		repeat (1) @(posedge clk);
		keycode <= `MOVE_LEFT_1;
		repeat (5) @(posedge clk);
		keycode <= 0;
        repeat (2) @(posedge clk);
		keycode <= `MOVE_ROTATE_1;
		repeat (4) @(posedge clk);
		keycode <= 0;
//		repeat (270) @(posedge clk);
//		// move second block to 2
//		keycode <= `MOVE_LEFT_1;
//		repeat (4) @(posedge clk);
//		keycode <= 0;
//		repeat (1) @(posedge clk);
//		keycode <= `MOVE_LEFT_1;
//		repeat (4) @(posedge clk);
//		keycode <= 0;
//		repeat (1) @(posedge clk);
//		repeat (600) @(posedge clk);
//		// third block is already at 4
//		// move fourth block to 6
//		keycode <= `MOVE_RIGHT_1;
//		repeat (4) @(posedge clk);
//		keycode <= 0;
//		repeat (1) @(posedge clk);
//		keycode <= `MOVE_RIGHT_1;
//		repeat (4) @(posedge clk);
//		keycode <= 0;
//		repeat (1) @(posedge clk);
//		repeat (280) @(posedge clk);
		
//		// move fifth block to 8
//		keycode <= `MOVE_RIGHT_1;
//		repeat (4) @(posedge clk);
//		keycode <= 0;
//		repeat (1) @(posedge clk);
//		keycode <= `MOVE_RIGHT_1;
//		repeat (4) @(posedge clk);
//		keycode <= 0;
//		repeat (1) @(posedge clk);
//        keycode <= `MOVE_RIGHT_1;
//		repeat (4) @(posedge clk);
//		keycode <= 0;
//		repeat (1) @(posedge clk);
//		keycode <= `MOVE_RIGHT_1;
//		repeat (4) @(posedge clk);
//		keycode <= 0;
//		repeat (1) @(posedge clk);
		$finish(); //this task will end the simulation if the Vivado settings are properly configured


	end

endmodule

