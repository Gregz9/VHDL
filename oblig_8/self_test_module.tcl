# add signals 
gtkwave::addSignalsFromList tb_self_test_module.tb_clk
gtkwave::addSignalsFromList tb_self_test_module.tb_reset
gtkwave::addSignalsFromList tb_self_test_module.tb_d0 
gtkwave::addSignalsFromList tb_self_test_module.tb_d1
gtkwave::addSignalsFromList tb_self_test_module.out_data

 

# make binary/highlight
gtkwave::highlightSignalsFromList tb_self_test_module.tb_clk
gtkwave::highlightSignalsFromList tb_self_test_module.tb_reset
gtkwave::highlightSignalsFromList tb_self_test_module.tb_d0
gtkwave::highlightSignalsFromList tb_self_test_module.tb_d1

# zoom to fit
gtkwave::/Time/Zoom/Zoom_Full
