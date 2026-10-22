set ::env(DESIGN_NAME) overtemp_controller
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/overtemp_controller.v]
set ::env(CLOCK_PORT) clk
set ::env(CLOCK_PERIOD) 10.0
set ::env(PDK) sky130A
set ::env(STD_CELL_LIBRARY) sky130_fd_sc_hd
set ::env(FP_CORE_UTIL) 30
set ::env(PL_TARGET_DENSITY) 0.45
set ::env(IO_PCT) 0.1
