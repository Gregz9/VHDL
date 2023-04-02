library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 

entity PWM is 
  port( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      duty_cycle: in signed(7 downto 0); 
      dir       : out std_logic; 
      en        : out std_logic
    ); 
end PWM; 

architecture rtl of PWM is 


