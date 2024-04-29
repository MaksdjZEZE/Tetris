`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/17 00:00:31
// Design Name: 
// Module Name: wait_clock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module wait_clock(
        input logic frame_clk,
        input logic Reset,
        input logic wait_clock_start,
        output logic wait_clock_en
    );
    logic [4:0] counter;
    
    enum logic [1:0] {
        WAIT_IDLE,
        WAIT_COUNT,
        WAIT_END
    } wait_state;
    always_ff @(posedge frame_clk or posedge Reset) begin
        if (Reset) begin
            wait_state <= WAIT_IDLE;
            counter <= 0;
        end else begin
            case(wait_state)
                WAIT_IDLE:
                    begin
                    counter <= 0;
                    wait_clock_en <= 0;
                    if (wait_clock_start) begin
                        wait_state <= WAIT_COUNT;
                    end
                    end
                WAIT_COUNT:
                    if (counter == 10) begin
                        wait_state <= WAIT_END;
                        wait_clock_en <= 1;
                    end else begin
                        counter <= counter + 1;
                        wait_clock_en <= 0;
                    end
                WAIT_END:
                    wait_state <= WAIT_IDLE;
            endcase
        end
    end
//    always_ff @(posedge frame_clk or posedge Reset)
//        begin
//            if(Reset)
//                wait_state <= WAIT_IDLE;
//            else
//                wait_state <= wait_state_next;
//        end
    
//    always_comb
//        begin
//            wait_clock_en = 1'b0;
//            case (wait_state)
//                WAIT_IDLE:
//                    counter = 3'b000;
//                WAIT_COUNT:
//                    counter = counter + 1;
//                WAIT_END:
//                    wait_clock_en = 1'b1;
//            endcase
//        end
        
//    always_comb
//        begin
//            wait_state_next = wait_state;
//            case (wait_state)
//                WAIT_IDLE:
//                    if (wait_clock_start)
//                        wait_state_next = WAIT_COUNT;
//                WAIT_COUNT:
//                    if (counter == 3'b100)
//                        wait_state_next = WAIT_END;
//                WAIT_END:
//                    wait_state_next = WAIT_IDLE;
//            endcase
//        end   
endmodule
