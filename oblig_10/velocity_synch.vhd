library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
library work; 
use work.all;

entity velocity_synchronizer is 
  port( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      velocity  : in signed(7 downto 0);  
      synch_velocity: out signed(7 downto 0); 
    ); 
end velocity_synchronizer; 

architecture rtl of velocity_synchronizer is 

begin 
 process(clk, reset) 
 begin 
    if reset then 
      synch_velocity <= (others => '0'); 
    elsif rising_edge(clk) then 
      synch_velocity <= velocity; 
    end if; 
  end process;
end architecture rtl;


