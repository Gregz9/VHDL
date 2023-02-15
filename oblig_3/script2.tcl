#add signals
gtkwave::addSignalsFromList tb_variables_vs_signals.indata
gtkwave::addSignalsFromList tb_variables_vs_signals.outdata
# gtkwave::addSignalsFromList tb_delay.indata
# gtkwave::addSignalsFromList tb_delay.outdata

# make binary
gtkwave::highlightSignalsFromList tb_variables_vs_signals.indata
gtkwave::highlightSignalsFromList tb_variables_vs_signals.outdata
gtkwave::/Edit/Data_Format/Binary

# zoom to fit
gtkwave::/Time/Zoom/Zoom_Full

# export image of wave
# gtkwave::/File/Grab_To_File wave.png
