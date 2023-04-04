library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use STD_textio.all; 
library work;
use work.all; 

entity tb_synchronizer is 
end tb_synchronizer; 

architecture rtl of tb_self_test_module is

  signal tb_clk         : std_logic := 0; 
  signal tb_reset       : std_logic := 0; 

