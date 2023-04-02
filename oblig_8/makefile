ENTITY_FILE_A=self_test_module.vhd
TB_FILE_A=tb_self_test_module.vhd
TB_ENTITY_A=tb_self_test_module
PACKAGE=utility_pkg.vhd
WAVE_A=self_test_wave.vcd

SIM_TIME_A=2400ns
SIM_TIME_LONGER=10000ns 

task_a: tb_self_test_module.vhd
	ghdl -a --std=08 $(PACKAGE)
	ghdl -a --std=08 $(ENTITY_FILE_A)
	ghdl -a --std=08 $(TB_FILE_A)
	ghdl -e --std=08 $(TB_ENTITY_A)
	ghdl -r --std=08 $(TB_ENTITY_A) --stop-time=$(SIM_TIME_LONGER) --vcd=$(WAVE_A)
	gtkwave --script self_test_module.tcl $(WAVE_A)

ENTITY_FILE_B=PWM_module.vhd
TB_FILE_B=tb_pwm_module.vhd
TB_ENTITY_B=tb_pulse_width_modulator
WAVE_B=pwm_wave.vcd

task_b: tb_pwm_module.vhd
	ghdl -a --std=08 $(ENTITY_FILE_B)
	ghdl -a --std=08 $(TB_FILE_B)
	ghdl -e --std=08 $(TB_ENTITY_B)
	ghdl -r --std=08 $(TB_ENTITY_B) --stop-time=$(SIM_TIME_LONGER) --vcd=$(WAVE_B)
	gtkwave --script self_test_module.tcl $(WAVE_B)


clean: 
	rm -f *.o
	rm -f *.vcd
	rm -f *.cf
	rm -f *.sav
	rm -f $(TB_ENTITY_A)
	rm -f $(TB_ENTITY_B)
