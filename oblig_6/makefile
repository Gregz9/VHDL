ENTITY_FILE=seg7model_ent.vhd
ARCH_FILE=seg7model_beh.vhd 
TB_FILE=tb_seg7model.vhd
TB_ENTITY=tb_seg7model
PACKAGE=utility_pkg.vhd
WAVE=seg7model.vcd

SIM_TIME=1us 
SIM_TIME_LONG= 6500ns
SIM_TIME_LONGER=160ms

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
TB2_FILE=tb_seg7ctrl.vhd
TB2_ENTITY=tb_seg7ctrl
WAVE2=seg7ctrl.vcd

task_b: 
	ghdl -a --std=08 $(PACKAGE)
	ghdl -a --std=08 $(ENTITY_FILE)
	ghdl -a --std=08 $(ARCH_FILE)
	ghdl -a --std=08 $(ENTITY2_FILE) 
	ghdl -a --std=08 $(ARCH2_FILE)
	ghdl -a --std=08 $(TB2_FILE)
	ghdl -e --std=08 $(TB2_ENTITY)
	ghdl -r --std=08 $(TB2_ENTITY) --stop-time=$(SIM_TIME_LONGER) --vcd=$(WAVE2)
	gtkwave --script seg7ctrl.tcl $(WAVE2)

ENTITY3_FILE=self_test_unit.vhd
TB3_FILE=tb_self_test_unit.vhd
TB3_ENTITY=tb_self_test_unit
WAVE3=self_test_wave.vcd

task_c: 
	ghdl -a --std=08 $(PACKAGE)
	ghdl -a --std=08 $(ENTITY_FILE)
	ghdl -a --std=08 $(ARCH_FILE)
	ghdl -a --std=08 $(ENTITY2_FILE) 
	ghdl -a --std=08 $(ARCH2_FILE)
	ghdl -a --std=08 $(ENTITY3_FILE)
	ghdl -a --std=08 $(TB3_FILE)
	ghdl -e --std=08 $(TB3_ENTITY)
	ghdl -r --std=08 $(TB3_ENTITY) --stop-time=$(SIM_TIME_LONG) --vcd=$(WAVE3)
	gtkwave --script self_test_unit.tcl $(WAVE3)

ENTITY4_FILE=self_test_system.vhd
TB4_FILE=tb_self_test_system.vhd
TB4_ENTITY=tb_self_test_system
WAVE4=self_test_system.vcd

task_d: 
	ghdl -a --std=08 $(PACKAGE)
	ghdl -a --std=08 $(ENTITY2_FILE)
	ghdl -a --std=08 $(ARCH2_FILE)
	ghdl -a --std=08 $(ENTITY3_FILE) 
	ghdl -a --std=08 $(ENTITY4_FILE)
	ghdl -a --std=08 $(TB4_FILE)
	ghdl -e --std=08 $(TB4_ENTITY)
	ghdl -r --std=08 $(TB4_ENTITY) --stop-time=$(SIM_TIME_LONGER) --vcd=$(WAVE4)
	gtkwave --script self_test_system.tcl $(WAVE4)


clean: 
	rm -f *.o
	rm -f *.vcd
	rm -f *.cf
	rm -f *.sav
	rm -f $(TB_ENTITY)
	rm -f $(TB2_ENTITY)
	rm -f $(TB3_ENTITY)
	rm -f $(TB4_ENTITY)

