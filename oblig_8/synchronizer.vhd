library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
library work; 
use work.all;

entity brute_synchronizer is 
  port( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      signal_a  : in std_logic; 
      signal_b  : in std_logic; 
      synch_signal_a : out std_logic; 
      synch_signal_b : out std_logic
    ); 
end brute_synchronizer; 

architecture rtl of brute_synchronizer is 

  component d_flip_flop
    port(
      clk   : in std_logic; 
      reset : in std_logic; 
      d     : in std_logic; 
      q     : out std_logic
    );
  end component d_flip_flop;

  signal q1_flip_flop, q2_flip_flop : std_logic; 
  signal q3_flip_flop, q4_flip_flop : std_logic; 

begin 
  dff1 : d_flip_flop port map(clk => clk, reset => reset, d => singal_a, q => q1_flip_flop);
  dff2 : d_flip_flop port map(clk => clk, reset => reset, d => q1_flip_flop, q => q2_flip_flop);

  dff3 : d_flip_flop port map(clk => clk, reset => reset, d => signal_b, q => q3_flip_flop);
  dff4 : d_flip_flop port map(clk => clk, reset => reset, d => q3_flip_flop, q => q4_flip_flop);

  synch_signal_a <= q2_flip_flop;
  synch_signal_b <= q4_flip_flop;
end architecture rtl;



