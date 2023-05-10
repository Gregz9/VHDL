library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity 8bit_dflip_flop is 
  port(
      clk       : in std_logic; 
      reset     : in std_logic; 
      d         : in std_logic_vector(7 downto 0); 
      q         : out std_logic_vector(7 downto 0) := "00000000" 
    ); 
end 8bit_dflip_flop; 

architecture rtl of 8bit_dflip_flop is 
begin 
  process(clk, reset) 
  begin 
    if reset = '1' then 
      q <= "00000000";
    elsif rising_edge(clk) then 
      q <= d;
    end if; 
  end process; 
end architecture rtl;
  
