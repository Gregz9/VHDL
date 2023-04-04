library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all 

entity d_flip_flop is 
  port(
      clk       : in std_logic; 
      reset     : in std_logic; 
      d         : in std_logic; 
      q         : out std_logic
    ); 
end d_flip_flop; 

architecture rtl of d_flip_flop is 
begin 
  process(clk, reset) 
  begin 
    if reset then 
      q <= '0';
    elsif rising_edge(clk) then 
      q <= d;
    end if; 
  end process; 
end architecture rtl;
  
