library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
library work;

entity tb_self_test_system is 
end tb_self_test_system; 

architecture rtl of tb_self_test_system is 

  signal tb_clk : std_logic; 
  signal tb_reset  : std_logic; 
  signal tb_abcdefg : std_logic_vector(6 downto 0); 
  signal tb_c : std_logic; 

begin 
  UUT : entity work.self_test_system(mixed) port map(tb_clk, tb_reset, tb_abcdefg, tb_c);

 CLK_0: process 
 begin 
   tb_clk <= '0';
   wait for 5 ns; 
   tb_clk <= '1';
   wait for 5 ns; 
 end process CLK_0; 

 end rtl;

