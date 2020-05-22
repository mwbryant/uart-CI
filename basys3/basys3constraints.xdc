## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

## Switches [0:7] 
set_property PACKAGE_PIN V17 [get_ports {newData[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {newData[0]}]
set_property PACKAGE_PIN V16 [get_ports {newData[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {newData[1]}]
set_property PACKAGE_PIN W16 [get_ports {newData[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {newData[2]}]
set_property PACKAGE_PIN W17 [get_ports {newData[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {newData[3]}]
set_property PACKAGE_PIN W15 [get_ports {newData[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {newData[4]}]
set_property PACKAGE_PIN V15 [get_ports {newData[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {newData[5]}]
set_property PACKAGE_PIN W14 [get_ports {newData[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {newData[6]}]
set_property PACKAGE_PIN W13 [get_ports {newData[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {newData[7]}]

#set_property PACKAGE_PIN R2 [get_ports {newDataReady}] #sw15 triggers write
#set_property IOSTANDARD LVCMOS33 [get_ports {newDataReady}]

## LEDS
set_property PACKAGE_PIN U16 [get_ports {ready}]
set_property IOSTANDARD LVCMOS33 [get_ports {ready}]


## Buttons
set_property PACKAGE_PIN T17 [get_ports newDataReady] ; #btnR
set_property IOSTANDARD LVCMOS33 [get_ports newDataReady]

##USB-RS232 Interface
set_property PACKAGE_PIN A18 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]


set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

set_operating_conditions -heatsink none
