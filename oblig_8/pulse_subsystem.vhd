 library IEEE; 
 use IEEE.std_logic_1164.all; 
 use IEEE.numeric_std.all; 

entity pulse_subsystem is 
  port( 
    clk         : in std_logic; 
    reset       : in std_logic; 
    dir_synch   : out std_logic; 
    en_synch    : out std_logic
  );
end pulse_subsystem;

architecture structural of pulse_subsystem is 

-- Component declaration
  component self_test_module
    port( 
      mclk      : in std_logic;
      reset     : in std_logic;
      duty_cycle : out std_logic_vector(7 downto 0);
    );
  end component self_test_module;

  component pulse_width_modulator
    port( 
      mclk      : in std_logic; 
      reset     : in std_logic; 
      duty_cycle: in std_logic_vector(7 downto 0);
      dir       : out std_logic; 
      en        : out std_logic
    );
  end component pulse_width_modulator;


