library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
library work; 
use work.utility.all; 

entity tb_seg7ctrl is 
end tb_seg7ctrl; 

architecture rtl of tb_seg7ctrl is 

  -- Test signals
  -- signal tb_bin        : std_logic_vector(4 downto 0) := "00000";
  signal tb_clk        : std_logic := '0';
  signal tb_reset      : std_logic := '0'; 
  signal tb_d0         : std_logic_vector(4 downto 0); 
  signal tb_d1         : std_logic_vector(4 downto 0); 
  signal tb_disp0      : std_logic_vector(4 downto 0); 
  signal tb_disp1      : std_logic_vector(4 downto 0); 
  signal tb_abcdefg    : std_logic_vector(6 downto 0); 
  signal tb_c          : std_logic;

  begin 
    -- Insatiating UUT 
    UUT : entity work.seg7ctrl(beh) port map(tb_clk, tb_reset, tb_d0, tb_d1, tb_abcdefg, tb_c);

    -- Insatiating simulation module
    seg7 : entity work.seg7model(beh) port map(tb_c, tb_abcdefg, tb_disp1, tb_disp0);

    P_CLK_0: process
    begin 
      tb_clk <= '0'; 
      wait for 10 ns; 
      tb_clk <= '1';
      wait for 10 ns; 
    end process P_CLK_0; 
  
  process begin
      for i in 0 to 31 loop 
        tb_d0 <= std_logic_vector(to_unsigned(i, 5));
        wait for 10 ms;
        tb_d1 <= std_logic_vector(to_unsigned(i, 5));
        wait for 10 ms;
      end loop; 
  std.env.stop(0);
  end process;
end rtl; 
