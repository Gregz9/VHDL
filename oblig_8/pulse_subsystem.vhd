 library IEEE; 
 use IEEE.std_logic_1164.all; 
 use IEEE.numeric_std.all; 
 library work;
 use work.all;

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
    generic(
      data_width: natural := 8;
      addr_width: natural := 5; 
      filename: string := "rom_data.txt"
    );
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

  component output_synchronizer
    port( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      dir       : in std_logic; 
      en        : in std_logic; 
      dir_synch : out std_logic; 
      en_synch  : out std_logic 
    );
  end component output_synchronizer;

  signal sub_duty_cycle : std_logic_vector(7 downto 0);
  signal sub_dir : std_logic; 
  signal sub_en  : std_logic; 

begin 

  SLFT : self_test_module
  port map(
        mclk => clk, 
        reset => reset, 
        duty_cycle => sub_duty_cycle
      ); 

  PWM : pulse_width_modulator
  port map( 
        mclk => clk, 
        reset => reset, 
        duty_cycle => sub_duty_cycle, 
        dir => sub_dir, 
        en => sub_en
      ); 

  SYNCH : output_synchronizer
  port map( 
        clk => clk, 
        reset => reset, 
        dir => sub_dir, 
        en => sub_en, 
        dir_synch => dir_synch, 
        en_synch => en_synch
      );

end architecture structural;


