
# Efinity Interface Designer SDC
# Version: 2023.1.150.3.11
# Date: 2024-11-24 13:11

# Copyright (C) 2017 - 2023 Efinix Inc. All rights reserved.

# Device: T20F256
# Project: piano
# Timing Model: C4 (final)

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {clk}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {clk}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {key[0]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {key[0]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {key[1]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {key[1]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {key[2]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {key[2]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {key[3]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {key[3]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {key[4]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {key[4]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {key[5]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {key[5]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {key[6]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {key[6]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {key[7]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {key[7]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {key[8]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {key[8]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {key[9]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {key[9]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {key_begin}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {key_begin}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {rst_n}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {rst_n}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {seg_led[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {seg_led[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {seg_led[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {seg_led[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {seg_led[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {seg_led[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {seg_led[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {seg_led[3]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {seg_led[4]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {seg_led[4]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {seg_led[5]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {seg_led[5]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {seg_led[6]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {seg_led[6]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {seg_sel}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {seg_sel}]

# LVDS RX GPIO Constraints
############################
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led[3]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led[4]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led[4]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led[5]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led[5]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led[6]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led[6]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led[7]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led[7]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led[8]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led[8]}]

# LVDS Rx Constraints
####################

# LVDS TX GPIO Constraints
############################
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {buzzer}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {buzzer}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led[9]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led[9]}]

# LVDS Tx Constraints
####################
