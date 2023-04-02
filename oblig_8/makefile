ENTITY_FILE=self_test_module.vhd
TB_FILE=tb_self_test_module.vhd
TB_ENTITY=tb_self_test_module
PACKAGE=utility_pkg.vhd
WAVE=self_test_wave.vcd

SIM_TIME_A=2400ns
SIM_TIME_LONGER=6500ns 

task_a: tb_self_test_module.vhd
	ghdl -a --std=08 $(PACKAGE)
	ghdl -a --std=08 $(ENTITY_FILE)
	ghdl -a --std=08 $(TB_FILE)
	ghdl -e --std=08 $(TB_ENTITY)
	ghdl -r --std=08 $(TB_ENTITY) --stop-time=$(SIM_TIME_LONGER) --vcd=$(WAVE)
	gtkwave --script self_test_module.tcl $(WAVE)

clean: 
	rm -f *.o
	rm -f *.vcd
	rm -f *.cf
	rm -f *.sav
	rm -f $(TB_ENTITY)
