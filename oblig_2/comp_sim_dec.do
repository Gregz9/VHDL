vcom -work work -2008 -explicit dec.vhd
vcom -work work -2008 -explicit tb_dec.vhd

vsim work.test_dec 
add wave sim:/test_dec/tb_sw
add wave sim:/test_dec/tb_led
run 1us 

