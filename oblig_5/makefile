ENTITY_FILE=pargen_sub.vhd 
TB_FILE=tb_pargen_proc.vhd
TB_ENTITY=tb_pargen # name from entity declaration
PACKAGE=subprog_pck.vhd
WAVE1=pargen_wave.vcd

SIM_TIME=1us # same as "run SIM_TIME" in questa
SIM_TIME_LONGER=2us

pargen:
	ghdl -a --std=08 $(PACKAGE)
	ghdl -a --std=08 $(ENTITY_FILE)
	ghdl -a --std=08 $(TB_FILE)
	ghdl -e --std=08 $(TB_ENTITY)
	ghdl -r --std=08 $(TB_ENTITY) --stop-time=$(SIM_TIME) --vcd=$(WAVE1)
	gtkwave --script pargen.tcl $(WAVE1)


clean:
	rm -f *.o
	rm -f *.vcd
	rm -f *.cf
	rm -f *.sav
	rm -f $(TB_ENTITY)
