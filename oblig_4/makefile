# d-flip-flop
COMPONENT_FILE=dff.vhd

# 8-bit shifter
ENTITY_FILE=8bit.vhd
TB_FILE=tb_8bit.vhd
TB_ENTITY=tb_8bit # name from entity declaration
WAVE1=8bit_wave.vcd

# 32 bit 
ENTITY_FILE2=32bit.vhd
TB_FILE2=tb_32bit.vhd
TB_ENTITY2=tb_32bit # name from entity declaration
WAVE2=32bit_wave.vcd

# n bit 
ENTITY_FILE3=nbit.vhd
TB_FILE3=tb_nbit.vhd
TB_ENTITY3=tb_nbit # name from entity declaration
WAVE3=nbit_wave.vcd

# Simulation time
SIM_TIME=1us # same as "run SIM_TIME" in questa
SIM_TIME_LONGER=2us

8bit:
	ghdl -a --std=08 $(COMPONENT_FILE)
	ghdl -a --std=08 $(ENTITY_FILE)
	ghdl -a --std=08 $(TB_FILE)
	ghdl -e --std=08 $(TB_ENTITY)
	ghdl -r --std=08 $(TB_ENTITY) --stop-time=$(SIM_TIME) --vcd=$(WAVE1)
	gtkwave --script 8bit.tcl $(WAVE1)

32bit:
	ghdl -a --std=08 $(COMPONENT_FILE)
	ghdl -a --std=08 $(ENTITY_FILE2)
	ghdl -a --std=08 $(TB_FILE2)
	ghdl -e --std=08 $(TB_ENTITY2)
	ghdl -r --std=08 $(TB_ENTITY2) --stop-time=$(SIM_TIME_LONGER) --vcd=$(WAVE2)
	gtkwave --script 32bit.tcl $(WAVE2)

nbit:
	ghdl -a --std=08 $(COMPONENT_FILE)
	ghdl -a --std=08 $(ENTITY_FILE3)
	ghdl -a --std=08 $(TB_FILE3)
	ghdl -e --std=08 $(TB_ENTITY3)
	ghdl -r --std=08 $(TB_ENTITY3) --stop-time=$(SIM_TIME_LONGER) --vcd=$(WAVE3)
	gtkwave --script nbit.tcl $(WAVE3)

clean:
	rm -f *.o
	rm -f *.vcd
	rm -f *.cf
	rm -f *.sav
	rm -f $(TB_ENTITY)
	rm -f $(TB_ENTITY2)
	rm -f $(TB_ENTITY3)
