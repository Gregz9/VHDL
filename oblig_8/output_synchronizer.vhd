library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
library work; 
use work.all;

entity output_synchronizer is 
  port( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      signal_a  : in std_logic; 
      signal_b  : in std_logic; 
      synch_signal_a : out std_logic; 
      synch_signal_b : out std_logic
    ); 
end output_synchronizer; 

architecture rtl of output_synchronizer is 

  component d_flip_flop
    port(
      clk   : in std_logic; 
      reset : in std_logic; 
      d     : in std_logic; 
      q     : out std_logic
    );
  end component d_flip_flop;

  signal q1_flip_flop, q2_flip_flop : std_logic; 

begin 
  dff1 : d_flip_flop port map(clk => clk, reset => reset, d => signal_a, q => q1_flip_flop);
  dff3 : d_flip_flop port map(clk => clk, reset => reset, d => signal_b, q => q2_flip_flop);

  synch_signal_a <= q1_flip_flop;
  synch_signal_b <= q2_flip_flop;
end architecture rtl;


