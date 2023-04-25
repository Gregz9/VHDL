ENTITY_FILE_A=compute_pipelined.vhd
TB_FILE_A=tb_compute_pipelined.vhd
TB_ENTITY_A=tb_compute_pipelined
WAVE_A=compute_pipelined.vcd

SIM_TIME_A=5000ns

task_a: 
	ghdl -a --std=08 $(ENTITY_FILE_A)
	ghdl -a --std=08 $(TB_FILE_A)
	ghdl -e --std=08 $(TB_ENTITY_A)
	ghdl -r --std=08 $(TB_ENTITY_A) --stop-time=$(SIM_TIME_A) --vcd=$(WAVE_A)
	gtkwave --script computed_pipelined.tcl $(WAVE_A)


clean: 
	rm -f *.o
	rm -f *.vcd
	rm -f *.cf
	rm -f *.sav
	rm -f $(TB_ENTITY_A)

