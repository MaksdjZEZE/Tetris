module wait_clock_testbench(); //even though the testbench doesn't create any hardware, it still needs to be a module

	timeunit 10ns;	// This is the amount of time represented by #1 
	timeprecision 1ns;

	// These signals are internal because the processor will be 
	// instantiated as a submodule in testbench.
	logic 		clk;
	logic		reset;
	logic 		wait_clock_start; // _i stands for input
	logic       wait_clock_en;
	
	logic [1:0] wait_state;
	logic [2:0] counter;


	
	// Instantiating the DUT (Device Under Test)
	// Make sure the module and signal names match with those in your design
	// Note that if you called the 8-bit version something besides 'Processor'
	// You will need to change the module name
	wait_clock wait_clock_test(
	   .frame_clk(clk),
	   .Reset(reset),
	   .wait_clock_start(wait_clock_start),
	   .wait_clock_en(wait_clock_en)
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
    
    assign wait_state = wait_clock_test.wait_state;
    assign counter = wait_clock_test.counter;
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
		wait_clock_start <= 1;
		repeat (2) @(posedge clk);
		wait_clock_start <= 0;
		repeat (20) @(posedge clk);
		$finish(); //this task will end the simulation if the Vivado settings are properly configured


	end

endmodule

