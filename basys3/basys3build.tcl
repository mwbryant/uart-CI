set_part "xc7a35tcpg236-1"

read_verilog [ glob ../*.v ]

read_xdc basys3constraints.xdc

synth_design -top uarttx ; #-directive runtimeoptimized

opt_design

place_design

route_design

write_bitstream -force basys3.bit
