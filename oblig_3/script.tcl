#add signals
gtkwave::addSignalsFromList tb_delay.rst_n
gtkwave::addSignalsFromList tb_delay.mclk
gtkwave::addSignalsFromList tb_delay.indata
gtkwave::addSignalsFromList tb_delay.outdata

# make binary
gtkwave::highlightSignalsFromList tb_delay.indata
gtkwave::highlightSignalsFromList tb_delay.outdata
gtkwave::/Edit/Data_Format/Binary

# zoom to fit
gtkwave::/Time/Zoom/Zoom_Full
