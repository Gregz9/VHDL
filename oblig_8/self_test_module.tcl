# add signals 
gtkwave::addSignalsFromList tb_self_test_module.tb_clk
gtkwave::addSignalsFromList tb_self_test_module.tb_reset
gtkwave::addSignalsFromList tb_self_test_module.tb_duty_cycle 
gtkwave::addSignalsFromList tb_self_test_module.out_data

 

# make binary/highlight
gtkwave::highlightSignalsFromList tb_self_test_module.tb_clk
gtkwave::highlightSignalsFromList tb_self_test_module.tb_reset
gtkwave::highlightSignalsFromList tb_self_test_module.tb_duty_cycle

# zoom to fit
gtkwave::/Time/Zoom/Zoom_Full
