ENTITY_FILE=seg7model_ent.vhd
ARCH_FILE=seg7model_beh.vhd 
TB_FILE=tb_seg7model.vhd
TB_ENTITY=tb_seg7model
PACKAGE=conv_bin_sig_pkg.vhd
WAVE=seg7model.vcd

SIM_TIME=1us 
SIM_TIME_LONGER=2us

seven: 
	ghdl -a --std=08 $(PACKAGE)
	ghdl -a --std=08 $(ENTITY_FILE)
	ghdl -a --std=08 $(ARCH_FILE)
	ghdl -a --std=08 $(TB_FILE)
	ghdl -e --std=08 $(TB_ENTITY)
	ghdl -r --std=08 $(TB_ENTITY) --stop-time=$(SIM_TIME_LONGER) --vcd=$(WAVE)
	gtkwave --script seg7model.tcl $(WAVE)


clean: 
	rm -f *.o
	rm -f *.vcd
	rm -f *.cf
	rm -f *.sav
	rm -f $(TB_ENTITY)

