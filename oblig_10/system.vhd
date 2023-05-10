library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
library work; 
use work.all;

entity system is 
  port( 
    clk         : in std_logic; 
    reset       : in std_logic; 
    SA          : in std_logic;
    SB          : in std_logic; 
    duty_cycle  : in std_logic_vector(7 downto 0);
    dir_synch   : out std_logic; 
    en_synch    : out std_logic; 
    abcdefg     : out std_logic_vector(6 downto 0);
    velocity    : out signed(7 donwto 0); 
    c           : out std_logic
  );
end entity system;  

architecture structural of system is 

-- Component declaration
  component velocity_subsystem 
    port( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      SA        : in std_logic; 
      SB        : in std_logic; 
      abcdefg   : out std_logic_vector(6 downto 0);
      c         : out std_logic; 
      synch_velocity : out signed(7 downto 0)
    ); 
  end component velocity_subsystem;

  component pulse_subsystem 
    port( 
      clk       : in std_logic;
      reset     : in std_logic; 
      duty_cycle: in std_logic_vector(7 downto 0);
      dir_synch : out std_logic; 
      en_synch  : out std_logic 
    );
  end component pulse_subsystem;

begin 

  VEL_SYS : velocity_subsystem 
  port map( 
      clk => clk, 
      reset => reset, 
      SA => SA,
      SB => SB, 
      abcdefg => abcdefg, 
      c => c, 
      synch_velocity => velocity
    );

  PLS_SYS : pulse_subsystem 
  port map(
      clk => clk,
      reset => reset, 
      duty_cycle => duty_cycle,
      dir_synch => dir_synch, 
      en_synch => en_synch
    );
end architecture structural;

