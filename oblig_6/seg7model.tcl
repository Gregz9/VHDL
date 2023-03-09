# add signals 
gtkwave::addSignalsFromList tb_seg7model.bin
gtkwave::addSignalsFromList tb_seg7model.tb_c 
gtkwave::addSignalsFromList tb_seg7model.tb_abcdefg 
gtkwave::addSignalsFromList tb_seg7model.tb_disp1
gtkwave::addSignalsFromList tb_seg7model.tb_disp0

# make binary/highlight
gtkwave::highlightSignalsFromList tb_seg7model.tb_c
gtkwave::highlightSignalsFromList tb_seg7model.tb_abcdefg
gtkwave::highlightSignalsFromList tb_seg7model.tb_disp0
gtkwave::highlightSignalsFromList tb_seg7model.tb_disp1

# zoom to fit
gtkwave::/Time/Zoom/Zoom_Full
