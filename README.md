# Tetris

## idea and overview
  We propose to develop a Tetris game on FPGA, employing a MicroBlaze soft microprocessor core. Our design will feature essential components like RAM, Video Display, Keyboard, and Audio, alongside peripherals including SPI for keyboard communication and an HDMI Controller for VGA to HDMI translation from previous labs. We'll use C code to develop keyboard drivers and implement Tetris functions in hardware (System Verilog). We would demonstrate a two-player Tetris game with score displaying using a USB keyboard and VGA monitor.

## basic features
  **basic functions of Tetris game**, including random generation and rotation of falling blocks, clear lines and scoring system, lock down (A piece has 0.5 seconds after landing on the stack before it locks down) and game over conditions, similar to what is described in the guideline of Tetris (except the rotation part, we didn’t apply super rotation system)
  
  * drawing blocks of different types  `- []`
  * falling blocks `- []`
  * rotation of blocks `- []`
  * failing and winning conditions `- []`
  * single player version `- []`
  * multi-player version `- []`
  * button for mode switch `- []`
  * support of strings display `- []`

  
## additional features
  We may want to add something more such as **Support of background music and sound effect**, **support for history score table with players' name**, **garbage system** (refered to <https://tetris.wiki/Tetris_Guideline>)

  * support of background music `- []`
  * support of sound effect `- []`
  * drawing history score table with players' name `- []`
  * support of garbage system `- []`

## difficulty points for this project
  5 points for basic game functionality, 2 for switching between single and mult-player version, 1 for audio, 0.5 for history score table, 0.5 for garbage system
