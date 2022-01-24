
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name RVGA -dir "C:/XILIX/RVGA/planAhead_run_1" -part xc6slx9tqg144-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "vga_driver.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {vga_driver.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top vga_driver $srcset
add_files [list {vga_driver.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx9tqg144-3
