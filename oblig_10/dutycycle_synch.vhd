library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
library work; 
use work.all;

entity dutycycle_synchronizer is 
  port( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      dutycycle  : in std_logic_vector(7 downto 0); 
      synch_dutycycle : out std_logic_vector(7 downto 0); 
    ); 
end dutycycle_synchronizer; 

architecture rtl of dutycycle_synchronizer is 

  component 8bit_dflip_flop is 
    port(
      clk   : in std_logic; 
      reset : in std_logic; 
      d     : in std_logic; 
      q     : out std_logic
    );
  end component 8bit_dflip_flop;

  signal q1_flip_flop, q2_flip_flop : std_logic_vector(7 downto 0); 


begin 
  dff1 : d_flip_flop port map(clk => clk, reset => reset, d => signal_a, q => q1_flip_flop);
  dff2 : d_flip_flop port map(clk => clk, reset => reset, d => q1_flip_flop, q => q2_flip_flop);


  synch_signal_a <= q2_flip_flop;
end architecture rtl;

