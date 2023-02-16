COMPONENT_FILE=dff.vhd
ENTITY_FILE=8bit.vhd
TB_FILE=tb_8bit.vhd
TB_ENTITY=tb_8bit # name from entity declaration
SIM_TIME=1us # same as "run SIM_TIME" in questa

8bit:
	ghdl -a --std=08 $(COMPONENT_FILE)
	ghdl -a --std=08 $(ENTITY_FILE)
	ghdl -a --std=08 $(TB_FILE)
	ghdl -e --std=08 $(TB_ENTITY)
	ghdl -r --std=08 $(TB_ENTITY) --stop-time=$(SIM_TIME) --vcd=waveform.vcd
	gtkwave --script 8bit.tcl waveform.vcd

clean:
	rm -f *.o
	rm -f *.vcd
	rm -f *.cf
	rm -f *.sav
	rm -f $(TB_ENTITY)
