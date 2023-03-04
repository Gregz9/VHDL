ENTITY_FILE=seg7model_ent.vhd
ARCH_FILE=seg7model_beh.vhd 
TB_FILE=tb_seg7model.vhd
TB_ENTITY=tb_seg7model
PACKAGE=conv_bin_sig_pkg.vhd
WAVE=seg7model.vcd

SIM_TIME=1us 
SIM_TIME_LONGER=640ms

task_a: 
	ghdl -a --std=08 $(PACKAGE)
	ghdl -a --std=08 $(ENTITY_FILE)
	ghdl -a --std=08 $(ARCH_FILE)
	ghdl -a --std=08 $(TB_FILE)
	ghdl -e --std=08 $(TB_ENTITY)
	ghdl -r --std=08 $(TB_ENTITY) --stop-time=$(SIM_TIME_LONGER) --vcd=$(WAVE)
	gtkwave --script seg7model.tcl $(WAVE)

ENTITY2_FILE=seg7ctrl_ent.vhd
ARCH2_FILE=seg7ctrl_beh.vhd
COMPONENT_FILE=counter.vhd
TB2_FILE=tb_seg7ctrl.vhd
TB2_ENTITY=tb_seg7ctrl
WAVE2=seg7ctrl.vcd

task_b: 
	ghdl -a --std=08 $(PACKAGE)
	ghdl -a --std=08 $(ENTITY_FILE)
	ghdl -a --std=08 $(ARCH_FILE)
	ghdl -a --std=08 $(COMPONENT_FILE)
	ghdl -a --std=08 $(ENTITY2_FILE) 
	ghdl -a --std=08 $(ARCH2_FILE)
	ghdl -a --std=08 $(TB2_FILE)
	ghdl -e --std=08 $(TB2_ENTITY)
	ghdl -r --std=08 $(TB2_ENTITY) --stop-time=$(SIM_TIME_LONGER) --vcd=$(WAVE2)
	gtkwave --script seg7ctrl.tcl $(WAVE2)

clean: 
	rm -f *.o
	rm -f *.vcd
	rm -f *.cf
	rm -f *.sav
	rm -f $(TB_ENTITY)
	rm -f $(TB2_ENTITY)

