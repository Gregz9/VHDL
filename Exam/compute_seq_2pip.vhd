library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 

entity compute_seq_2pip; is 
  port( 
      clk   : in std_logic;
      a   : in std_logic_vector(15 downto 0); 
      b   : in std_logic_vector(15 downto 0); 
      c   : in std_logic_vector(15 downto 0); 
      d   : in std_logic_vector(15 downto 0); 
      vdata   : in std_logic;
      vresult : out std_logic; 
      result  : std_logic_vector(17 downto 0)); 
end entity compute_seq_2pip;

architecture compute_seq_2pip is 

  signal next_vdata : std_logic;
  signal next_vresult :std_logic;
  signal sum_ab_i, sum_ab_r, sum_cd_i, sum_cd_r, result_i, result_r :unsigned(17 downto 0);

  COMPUTING : process (all)
  begin 
    sum_ab_i <= unsigned("00" & a) + unsigned("00" & b); 
    sum_cd_i <= unsigned("00" & a) + unsigned("00" & b); 
    result_i <= sum_ab_r + sum_cd_r when next_vresult else (others => '0');
  end process COMPUTING; 

  UPDATE : process (clk): 
  begin 
    if rising_edge(clk) then 
      sum_ab_r <= sum_ab_i;
      sum_cd_r <= sum_cd_i;
      result_r <= result_i
      next_vresult <= vdata; 
      result <= std_logic_vector(result_r);
    
    end if; 
  end process; 


end architecture;


