# add signals 
gtkwave::addSignalsFromList tb_8bit.tb_clk
gtkwave::addSignalsFromList tb_8bit.tb_reset
gtkwave::addSignalsFromList tb_8bit.tb_indata
gtkwave::addSignalsFromList tb_8bit.tb_s_out
gtkwave::addSignalsFromList tb_8bit.tb_p_out

# make binary 
gtkwave::highlightSignalsFromList tb_8bit.tb_s_out
gtkwave::highlightSignalsFromList tb_8bit.tb_p_out
gtkwave::/Edit/Data_Format/Binary


# zoom to fit
gtkwave::/Time/Zoom/Zoom_Full
