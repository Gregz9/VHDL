# add signals 
gtkwave::addSignalsFromList tb_nbit.tb_clk
gtkwave::addSignalsFromList tb_nbit.tb_reset
gtkwave::addSignalsFromList tb_nbit.tb_indata
gtkwave::addSignalsFromList tb_nbit.tb_s_out
gtkwave::addSignalsFromList tb_nbit.tb_p_out

# make binary 
gtkwave::highlightSignalsFromList tb_nbit.tb_s_out
gtkwave::highlightSignalsFromList tb_nbit.tb_p_out
gtkwave::/Edit/Data_Format/Binary


# zoom to fit
gtkwave::/Time/Zoom/Zoom_Full
