ENITY_FILE=delay.vhd
#ARCH_FILE=decoder_arch.vhd
TB_FILE=tb_delay.vhd
TB_ENTITY=tb_delay # name from entity declaration
SIM_TIME=1us # same as "run SIM_TIME" in questa

all:
	ghdl -a --std=08 $(ENITY_FILE)
	#ghdl -a --std=08 $(ARCH_FILE)
	ghdl -a --std=08 $(TB_FILE)
	ghdl -e --std=08 $(TB_ENTITY)
	ghdl -r --std=08 $(TB_ENTITY) --stop-time=$(SIM_TIME) --vcd=waveform.vcd
	gtkwave --script script.tcl waveform.vcd

clean:
	rm -f *.o
	rm -f *.vcd
	rm -f *.cf
	rm -f *.sav
	rm -f $(TB_ENTITY)
