library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 

entity compute_seq is 
  port
    (clk    : in std_logic; 
     a      : in std_logic_vector(15 downto 0); 
     b      : in std_logic_vector(15 downto 0); 
     c      : in std_logic_vector(15 downto 0); 
     d      : in std_logic_vector(15 downto 0); 
     result : out std_logic_vector(17 downto 0));
end entity compute_seq;

architecture rtl of compute_seq is 

  signal sum_i : unsigend(17 downto 0) := (others => "0");
  signal result_i : unsigend(17 downto 0) := (others => "0");

  SUMMING : process (all)
  begin 
    sum_i <= unsigned("00" & a) +unsigned("00" & b) + unsigned("00" & c) + unsigned("00" & d)
  end process;

  UPDATE: process (clk): 
  begin 
    if rising_edge(clk) then 
      result_r <= sum_i;
    end if; 
  end process; 

  result <= result_r; 

end architecture;

