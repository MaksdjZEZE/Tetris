`timescale 1ns / 1ps

module ScoreToAscii(
    input logic [15:0] score,
    input logic [1:0] selector,
    output logic [11:0] ascii_address
    );
    
    logic [3:0] digit0, digit1, digit2, digit3, selected_digit;
    always_comb 
    begin
        digit0 = score[15:12];
        digit1 = score[11:8];
        digit2 = score[7:4];
        digit3 = score[3:0];
        
        case(selector)
            2'b00: selected_digit = digit0;
            2'b01: selected_digit = digit1;
            2'b10: selected_digit = digit2;
            2'b11: selected_digit = digit3;
            default: selected_digit = digit0;
        endcase
        
        case(selected_digit)
            4'b0000: ascii_address = 11'h30;
            4'b0001: ascii_address = 11'h31;
            4'b0010: ascii_address = 11'h32;
            4'b0011: ascii_address = 11'h33;
            4'b0100: ascii_address = 11'h34;
            4'b0101: ascii_address = 11'h35;            
            4'b0110: ascii_address = 11'h36;
            4'b0111: ascii_address = 11'h37; 
            4'b1000: ascii_address = 11'h38;
            4'b1001: ascii_address = 11'h39;  
            4'b1010: ascii_address = 11'h41;
            4'b1011: ascii_address = 11'h42;
            4'b1100: ascii_address = 11'h43;
            4'b1101: ascii_address = 11'h44;
            4'b1110: ascii_address = 11'h45;
            4'b1111: ascii_address = 11'h46;
            default: ascii_address = 11'h30;  
        endcase
    end
endmodule