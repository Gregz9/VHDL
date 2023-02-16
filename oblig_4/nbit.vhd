library ieee; 
use ieee.std_logic_1164.all; 

entity shiftern is
  generic( n: integer := 8);
  port ( 
      indata        : in std_logic; 
      s_clk         : in std_logic; 
      rst_n         : in std_logic; 
      s_out         : out std_logic; 
      p_out         : out std_logic_vector(n-1 downto 0)
    );
end shiftern; 

architecture parser of shiftern is 
  
  signal reg_shift : std_logic_vector(n downto 0); 
  signal in_shift  : std_logic;
  
  begin 
    shiftn: for i in 0 to n-1 generate
      dff_i: entity work.dff(rtl)
        port map ( 
          rst_n => rst_n, 
          mclk => s_clk, 
          din => reg_shift(i),
          dout => reg_shift(i+1)
        );
      end generate; 
    
    reg_shift(0) <= indata;  
    s_out <= reg_shift(n);
    p_out <= reg_shift(n downto 1); 

end parser; 

