library ieee; 
use ieee.std_logic_1164.all; 

entity tb_32bit is 
end tb_32bit; 

architecture test of tb_32bit is

  -- UUT signals
  signal tb_clk        : std_logic := '0'; 
  signal tb_reset      : std_logic := '0'; 
  signal tb_indata     : std_logic := '0'; 
  signal tb_s_out      : std_logic; 
  signal tb_p_out      : std_logic_vector(31 downto 0); 

begin 
  UUT : entity work.shifter32(parser) port map(tb_indata, tb_clk, tb_reset, tb_s_out, tb_p_out); 
    
    clk_proc : process
    begin
      tb_clk <= '0'; 
      wait for 20 ns; 
      tb_clk <= '1';
      wait for 20 ns; 
    end process; 

    test_proc : process
    begin 
      tb_reset <= '0', '1' after 100 ns; 
      tb_indata <= '0', '1' after 100 ns, '0' after 300 ns;    
      wait;
    end process; 

end test;
