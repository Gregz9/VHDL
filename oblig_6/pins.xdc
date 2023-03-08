set_property PACKAGE_PIN AB7 [get_ports {abcdefg[6]}]
set_property PACKAGE_PIN AB6 [get_ports {abcdefg[5]}]
set_property PACKAGE_PIN Y4 [get_ports {abcdefg[4]}]
set_property PACKAGE_PIN AA4 [get_ports {abcdefg[3]}]
set_property PACKAGE_PIN V7 [get_ports {abcdefg[2]}]
set_property PACKAGE_PIN W7 [get_ports {abcdefg[1]}]
set_property PACKAGE_PIN V5 [get_ports {abcdefg[0]}]
set_property PACKAGE_PIN V4 [get_ports c]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {abcdefg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports c]
set_property IOSTANDARD LVCMOS33 [get_ports mclk]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN T18 [get_ports mclk]
set_property PACKAGE_PIN P16 [get_ports reset]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets mclk]

create_clock -period 10.000 -waveform {0.000 5.000} [get_ports mclk]