library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

architecture beh of seg7ctrl is 
    
  component counter 
    port (
          clk       : in std_logic;
          reset     : in 
