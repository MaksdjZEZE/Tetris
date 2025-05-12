`timescale 1ns / 1ps
module Sound_Effect#(
    parameter TIME_500MS = 25'd5999999, 
    parameter DO = 18'd190839 , 
    parameter RE = 18'd170067 , 
    parameter MI = 18'd151514 , 
    parameter FA = 18'd143265 , 
    parameter SO = 18'd127550 , 
    parameter LA = 18'd113635 , 
    parameter XI = 18'd101214 , 
    parameter WHAT = 18'd190839
)
(
    input logic btn_pressed, // pressed button
    input logic sys_clk, // 100 MHz System Clock
    input logic sys_rst_n, // reset signal, low active
    output logic beep_effect
);
    // Parameter and Internal Signal
logic [24:0] cnt; 
logic [17:0] freq_cnt; 
logic [5:0] cnt_500ms; 
logic [17:0] freq_data; 

// Main Code

// duty cycle = 50%, affecting music volume
logic [16:0] duty_data; 
assign duty_data = freq_data >> 4;

always @(posedge sys_clk or negedge sys_rst_n)
begin
    if ((~sys_rst_n) || (btn_pressed))
        cnt <= 25'd0;
    else if (cnt == TIME_500MS)
        cnt <= 25'd0;
    else
        cnt <= cnt + 1'b1;
end


always @(posedge sys_clk or negedge sys_rst_n)
begin
    if (~sys_rst_n)
        cnt_500ms <= 6'd0;
    else if ((cnt == TIME_500MS) && (cnt_500ms == 6'd46))
        cnt_500ms <= 6'd0;
    else if (cnt == TIME_500MS)
        cnt_500ms <= cnt_500ms + 1'b1;
end

always @(posedge sys_clk or negedge sys_rst_n)
begin
    if (~sys_rst_n)
        freq_data <= 0;
    else if (btn_pressed)
        freq_data <= WHAT;
    else if (cnt == TIME_500MS)
        freq_data <= 0;
end

always @(posedge sys_clk or negedge sys_rst_n)
begin
    if ((~sys_rst_n))
        freq_cnt <= 18'd0;
    else if ((freq_cnt == freq_data))
        freq_cnt <= 18'd0;
    else
        freq_cnt <= freq_cnt + 1'b1;
end

always @(posedge sys_clk or negedge sys_rst_n)
begin
    if (~sys_rst_n)
        beep_effect <= 1'b0;
    else if (freq_cnt <= duty_data)
        beep_effect <= 1'b1;
    else
        beep_effect <= 1'b0;
end

endmodule
