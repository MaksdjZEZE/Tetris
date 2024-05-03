# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct D:\ece385sp24\Tetris\tetris_workspace\tetris_top\platform.tcl
# 
# OR launch xsct and run below command.
# source D:\ece385sp24\Tetris\tetris_workspace\tetris_top\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {tetris_top}\
-hw {D:\ece385sp24\Tetris\tetris_hardware\tetris_top.xsa}\
-out {D:/ece385sp24/Tetris/tetris_workspace}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {tetris_top}
platform generate -quick
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
platform active {tetris_top}
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform clean
platform generate
platform config -updatehw {D:/ece385sp24/Tetris/tetris_hardware/tetris_top.xsa}
platform clean
platform generate
