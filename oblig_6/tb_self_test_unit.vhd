library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 

entity tb_self_test_unit is 
end tb_self_test_unit;

architecture rtl of tb_self_test_unit is

  signal tb_clk        : std_logic := '0';
  signal tb_reset      : std_logic := '0'; 
  signal tb_d0         : std_logic_vector(4 downto 0); 
  signal tb_d1         : std_logic_vector(4 downto 0);

begin 
  UUT : entity work.self_test_unit(beh) port map(tb_clk, tb_reset, tb_d0, tb_d1);

  P_CLK_0: process
    begin 
      tb_clk <= '0'; 
      wait for 10 ns; 
      tb_clk <= '1';
      wait for 10 ns; 
    end process P_CLK_0;

    /* tb_reset <= '1', '0' after 580 ns; */
end rtl; 

