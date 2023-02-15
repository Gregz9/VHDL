ENITY_FILE=delay.vhd
#ARCH_FILE=decoder_arch.vhd
TB_FILE=tb_delay.vhd
TB_ENTITY=tb_delay # name from entity declaration
SIM_TIME=1us # same as "run SIM_TIME" in questa
ENTITY_FILE2=variables_vs_signals.vhd
TB_FILE2=tb_variables_vs_signals.vhd
TB_ENTITY2=tb_variables_vs_signals

ab:
	ghdl -a --std=08 $(ENITY_FILE)
	#ghdl -a --std=08 $(ARCH_FILE)
	ghdl -a --std=08 $(TB_FILE)
	ghdl -e --std=08 $(TB_ENTITY)
	ghdl -r --std=08 $(TB_ENTITY) --stop-time=$(SIM_TIME) --vcd=waveform.vcd
	gtkwave --script script.tcl waveform.vcd

cd: 
	ghdl -a --std=08 $(ENTITY_FILE2)
	ghdl -a --std=08 $(TB_FILE2) 
	ghdl -e --std=08 $(TB_ENTITY2) 
	ghdl -r --std=08 $(TB_ENTITY2) --stop-time=$(SIM_TIME) --vcd=waveform2.vcd
	gtkwave	--script script2.tcl waveform2.vcd 

clean:
	rm -f *.o
	rm -f *.vcd
	rm -f *.cf
	rm -f *.sav
	rm -f $(TB_ENTITY)
	rm -r $(TB_ENTITY2)
