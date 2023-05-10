 library IEEE; 
 use IEEE.std_logic_1164.all; 
 use IEEE.numeric_std.all; 
 library work;


entity pulse_subsystem is 
  port( 
    clk         : in std_logic; 
    reset       : in std_logic; 
    duty_cycle  : in std_logic_vector(7 downto 0);
    dir_synch   : out std_logic; 
    en_synch    : out std_logic
  );
end entity pulse_subsystem;

architecture structural of pulse_subsystem is 

-- Component declaration

  component dutycycle_synchronizer is 
    port( 
      clk	: in std_logic; 
      reset 	: in std_logic; 
      dutycycle : in std_logic_vector(7 downto 0); 
      synch_dutycycle : out std_logic_vector(7 downto 0)
    ); 
  end component dutycycle_synchronizer; 

  component pulse_width_modulator is
    port( 
      mclk      : in std_logic; 
      reset     : in std_logic; 
      duty_cycle: in std_logic_vector(7 downto 0);
      dir       : out std_logic; 
      en        : out std_logic
    );
  end component pulse_width_modulator;

  component output_synchronizer is 
    port( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      dir       : in std_logic; 
      en        : in std_logic; 
      dir_synch : out std_logic; 
      en_synch  : out std_logic 
    );
  end component output_synchronizer;

  signal sub_dir : std_logic; 
  signal sub_en  : std_logic; 
  signal synch_duty : std_logic_vector(7 downto 0); 

begin 

  DUSYNCH : dutycycle_synchronizer
  port map( 
        clk => clk, 
        reset => reset, 
        dutycycle => duty_cycle, 
        synch_dutycycle => synch_duty 
 	); 

  PWM : pulse_width_modulator
  port map( 
        mclk => clk, 
        reset => reset, 
        duty_cycle => synch_duty, 
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


