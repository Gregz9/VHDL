library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
library work;
use work.utility.all;

architecture beh of seg7ctrl is

  -- Counter specific signals
  signal c_count : integer := 0; 
  signal c_count_i : integer; 
  -- seg7ctrl specific signals
  signal seg7_out : std_logic_vector(6 downto 0);
  signal d_select : std_logic := '0';

begin

  COUNTING: 
  process (all)
  begin 
    c_count_i <= c_count + 1; 
  end process COUNTING;

  process(mclk, reset)
  begin
    if reset = '1' then
      c_count <= 0;
    elsif rising_edge(mclk) then
      c_count <= c_count + 1;
      if c_count = 1000000 then  -- 100 MHz clock / 50 Hz frequency = 2 * 1e6 cycles
        d_select <= not d_select;
        c_count <= 0; 
      end if;
    end if;
  end process; 
  
  c <= d_select;
  abcdefg <= bin2ssd(d1) when c = '1' else bin2ssd(d0);
end beh;
 

  
          
