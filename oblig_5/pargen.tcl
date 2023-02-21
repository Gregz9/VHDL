# add signals
gtkwave::addSignalsFromList tb_pargen.rst_n
gtkwave::addSignalsFromList tb_pargen.mclk
gtkwave::addSignalsFromList tb_pargen.indata1
gtkwave::addSignalsFromList tb_pargen.indata2
gtkwave::addSignalsFromList tb_pargen.par

# make binary 
gtkwave::highlightSignalsFromList tb_pargen.indata1
gtkwave::highlightSignalsFromList tb_pargen.indata2
gtkwave::highlightSignalsFromList tb_pargen.par

# zoom to fit
gtkwave::/Time/Zoom/Zoom_Full
