###############################################################################
# Created by write_sdc
# Thu Oct 15 16:18:25 2026
###############################################################################
current_design overtemp_controller
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_propagated_clock [get_clocks {clk}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {manual_clear}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {overtemp_in}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rst_n}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {system_enable}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {cooling_enable}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {shutdown}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {system_running}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {warning}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {cooling_enable}]
set_load -pin_load 0.0334 [get_ports {shutdown}]
set_load -pin_load 0.0334 [get_ports {system_running}]
set_load -pin_load 0.0334 [get_ports {warning}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {manual_clear}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {overtemp_in}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rst_n}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {system_enable}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_fanout 10.0000 [current_design]
