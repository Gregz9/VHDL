# add signals 
gtkwave::addSignalsFromList tb_self_test_system.tb_clk
gtkwave::addSignalsFromList tb_self_test_system.tb_reset
gtkwave::addSignalsFromList tb_self_test_system.tb_abcdefg
gtkwave::addSignalsFromList tb_self_test_system.tb_c


# make binary/highlight
gtkwave::highlightSignalsFromList tb_self_test_system.tb_clk
gtkwave::highlightSignalsFromList tb_self_test_system.tb_reset
gtkwave::highlightSignalsFromList tb_self_test_system.tb_abcdefg
gtkwave::highlightSignalsFromList tb_self_test_system.tb_c

# zoom to fit
gtkwave::/Time/Zoom/Zoom_Full
