vcom -work work -2008 -explicit dec24.vhd
vcom -work work -2008 -explicit dselect_arch.vhd
vcom -work work -2008 -explicit dcase_arch.vhd
vcom -work work -2008 -explicit tb_dec24.vhd

vsim work.test_dec 
add wave sim:/test_dec/tb_sw1
add wave sim:/test_dec/tb_sw2
add wave sim:/test_dec/tb_led1 
add wave sim:/test_dec/tb_led2
run 1us
