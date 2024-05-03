module MP3(
    input logic btn_pressed, // pressed button
    input logic sys_clk, // 100 MHz System Clock
    input logic sys_rst_n, // reset signal, low active
    output logic pwm_out1, // PWM signal output
    output logic pwm_out2 // sound effect of button press
);
    
    logic beep_final, beep_effect_final;

    logic beep, beep_effect;
    beep beeper(.*);
    Sound_Effect sound_effect(.*);
    
    always_ff @(posedge sys_clk)
    begin
            
            pwm_out1 <= beep;
            pwm_out2 <= beep_effect;
    end
endmodule