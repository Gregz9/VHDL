library ieee; 
use ieee.std_logic_1164.all; 

entity shifter8 is 
  port ( 
      indata        : in std_logic; 
      s_clk         : in std_logic; 
      rst_n         : in std_logic; 
      s_out         : out std_logic; 
      p_out         : out std_logic_vector(7 downto 0)
    );
end shifter8; 

architecture parser of shifter8 is
  
  signal reg_shift : std_logic_vector(8 downto 0); 
  
  begin

    dff0 : entity work.dff(rtl) port map (rst_n, s_clk, reg_shift(0), reg_shift(1));
    dff1 : entity work.dff(rtl) port map (rst_n, s_clk, reg_shift(1), reg_shift(2));
    dff2 : entity work.dff(rtl) port map (rst_n, s_clk, reg_shift(2), reg_shift(3));
    dff3 : entity work.dff(rtl) port map (rst_n, s_clk, reg_shift(3), reg_shift(4)); 
    dff4 : entity work.dff(rtl) port map (rst_n, s_clk, reg_shift(4), reg_shift(5)); 
    dff5 : entity work.dff(rtl) port map (rst_n, s_clk, reg_shift(5), reg_shift(6));
    dff6 : entity work.dff(rtl) port map (rst_n, s_clk, reg_shift(6), reg_shift(7));
    dff7 : entity work.dff(rtl) port map (rst_n, s_clk, reg_shift(7), reg_shift(8)); 

    reg_shift(0) <= indata;  
    s_out <= reg_shift(8);
    p_out <= reg_shift(8 downto 1); 

end parser; 

