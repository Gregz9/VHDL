library ieee; 
use ieee.std_logic_1164.all; 

entity shifter32 is 
  port ( 
      indata        : in std_logic; 
      s_clk         : in std_logic; 
      rst_n         : in std_logic; 
      s_out         : out std_logic; 
      p_out         : out std_logic_vector(31 downto 0)
    );
end shifter32; 

architecture parser of shifter32 is 
  
  signal reg_shift : std_logic_vector(32 downto 0); 
  signal in_shift  : std_logic;
  
  begin 
    shift8: for i in 0 to 31 generate
      dff_i: entity work.dff(rtl)
        port map ( 
          rst_n => rst_n, 
          mclk => s_clk, 
          din => reg_shift(i),
          dout => reg_shift(i+1)
        );
      end generate; 
    
    reg_shift(0) <= indata;  
    s_out <= reg_shift(32);
    p_out <= reg_shift(32 downto 1); 

end parser; 

