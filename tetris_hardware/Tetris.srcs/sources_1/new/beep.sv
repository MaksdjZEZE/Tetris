module beep #(
//    parameter TIME_500MS = 25'd24999999, 
    parameter TIME_500MS = 25'd24999999, 
    parameter DO = 18'd190839 , 
    parameter RE = 18'd170067 , 
    parameter MI = 18'd151514 ,
    parameter FA = 18'd143265 , 
    parameter SO = 18'd127550 , 
    parameter LA = 18'd113635 ,
    parameter XI = 18'd101214  
)
(
    input logic sys_clk, // 100 MHz System Clock
    input logic sys_rst_n, // when pressed, play music
    output logic beep // PWM signal output
);

// Parameter and Internal Signal
logic [24:0] cnt; 
logic [17:0] freq_cnt; 
logic [5:0] cnt_500ms; 
logic [17:0] freq_data; 

// Main Code

// duty cycle = 50%, affecting music volume
logic [16:0] duty_data; 
assign duty_data = freq_data >> 1'b1;

always @(posedge sys_clk or negedge sys_rst_n)
begin
    if (~sys_rst_n)
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
        freq_data <= DO;
    else
    begin
        case(cnt_500ms)
            0: freq_data <= DO;
            1: freq_data <= DO;
            2: freq_data <= SO;
            3: freq_data <= SO;
            4: freq_data <= LA;
            5: freq_data <= LA;
            6: freq_data <= SO;
            7: freq_data <= 0;
            
            8: freq_data <= FA;
            9: freq_data <= FA;
            10: freq_data <= MI;
            11: freq_data <= MI;
            12: freq_data <= RE;
            13: freq_data <= RE;
            14: freq_data <= DO;
            15: freq_data <= 0;
            
            16: freq_data <= SO;
            17: freq_data <= SO;
            18: freq_data <= FA;
            19: freq_data <= FA;
            20: freq_data <= MI;
            21: freq_data <= MI;
            22: freq_data <= RE;
            23: freq_data <= 0;
            
            24: freq_data <= SO;
            25: freq_data <= SO;
            26: freq_data <= FA;
            27: freq_data <= FA;
            28: freq_data <= MI;
            29: freq_data <= MI;
            30: freq_data <= RE;
            31: freq_data <= 0;
            
            32: freq_data <= DO;
            33: freq_data <= DO;
            33: freq_data <= SO;
            34: freq_data <= SO;
            35: freq_data <= LA;
            36: freq_data <= LA;
            37: freq_data <= SO;
            38: freq_data <= 0;
            
            39: freq_data <= FA;
            40: freq_data <= FA;
            41: freq_data <= MI;
            42: freq_data <= MI;
            43: freq_data <= RE;
            44: freq_data <= RE;
            45: freq_data <= DO;
            46: freq_data <= 0;
            default: freq_data <= DO;
        endcase
    end
end

always @(posedge sys_clk or negedge sys_rst_n)
begin
    if (~sys_rst_n)
        freq_cnt <= 18'd0;
    else if ((freq_cnt == freq_data) || (cnt == TIME_500MS))
        freq_cnt <= 18'd0;
    else
        freq_cnt <= freq_cnt + 1'b1;
end

always @(posedge sys_clk or negedge sys_rst_n)
begin
    if (~sys_rst_n)
        beep <= 1'b0;
    else if (freq_cnt >= duty_data)
        beep <= 1'b1;
    else
        beep <= 1'b0;
end

endmodule
