# add signals 
gtkwave::addSignalsFromList tb_seg7ctrl.tb_clk 
gtkwave::addSignalsFromList tb_seg7ctrl.tb_reset 
gtkwave::addSignalsFromList tb_seg7ctrl.tb_d0
gtkwave::addSignalsFromList tb_seg7ctrl.tb_d1
gtkwave::addSignalsFromList tb_seg7ctrl.tb_disp0
gtkwave::addSignalsFromList tb_seg7ctrl.tb_disp1
gtkwave::addSignalsFromList tb_seg7ctrl.tb_abcdefg
gtkwave::addSignalsFromList tb_seg7ctrl.tb_c

# make binary/highlight
gtkwave::highlightSignalsFromList tb_seg7ctrl.tb_d0
gtkwave::highlightSignalsFromList tb_seg7ctrl.tb_d1 
gtkwave::highlightSignalsFromList tb_seg7ctrl.tb_disp0
gtkwave::highlightSignalsFromList tb_seg7ctrl.tb_disp1
gtkwave::highlightSignalsFromList tb_seg7ctrl.abcdefg

# zoom to fit
gtkwave::/Time/Zoom/Zoom_Full
