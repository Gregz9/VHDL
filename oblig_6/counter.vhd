library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ncounter is
  generic(n: integer := 4);
  port
    (
      clk       : in  std_logic;        -- Clock signal from push button
      reset     : in  std_logic;        -- Global asynchronous reset
      up        : in  std_logic;        -- Count up/down control signal 
      count     : out unsigned(n-1 downto 0)  -- Count value
      );
end ncounter;

-- The architecture below describes a 4-bit up counter. When the counter
-- reaches its maximum value, the signal MAX_COUNT is activated.

architecture beh of ncounter is
  
  constant min : unsigned(n-1 downto 0) := (others => '0');

  --  Area for declarations
  signal count_i : unsigned(n-1 downto 0);
  
begin
  --  The description starts here
  
  COUNTING :
  process (all)
  begin 
      if up = '1' then
        count_i <= count + 1;
      else 
        count_i <= count - 1;
      end if;

  end process COUNTING;

  STORING:
  process (reset, clk)
  begin
    -- Asynchronous reset
    if(reset = '1') then
      count <= min;
    elsif rising_edge(CLK) then
      count <= count_i;
    end if;
  end process STORING;

end beh;
