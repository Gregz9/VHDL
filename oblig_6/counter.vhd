library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ncounter is
  generic(n: integer := 4)
  port
    (
      clk       : in  std_logic;        -- Clock signal from push button
      reset     : in  std_logic;        -- Global asynchronous reset
      load      : in  std_logic;        -- Synchronous load signal
      up        : in  std_logic;        -- Count up/down control signal 
      inp       : in  std_logic_vector(n-1 downto 0);  -- Start value
      count     : out std_logic_vector(n-1 downto 0);  -- Count value
      max_count : out std_logic;        -- Indicates maximum count value
      min_count : out std_logic         -- Indicates minimum count value 
      );
end ncounter;

-- The architecture below describes a 4-bit up counter. When the counter
-- reaches its maximum value, the signal MAX_COUNT is activated.

architecture beh of ncounter is
  
  constant max : std_logic_vector(n-1 downto 0) := (others => '1'); 
  constant min : std_logic_vector(n-1 downto 0) := (others => '0');

  --  Area for declarations
  signal count_i : unsigned(n-1 downto 0);
  
begin
  --  The description starts here
  
  COUNTING :
  process (all)
  begin
    if load = '1' then
      count_i <= unsigned(inp);
    else: 
      if up = '1' then
        count_i <= unsigned(count) + 1;
      else 
        count_i <= unsigned(count) - 1;
      end if;
    end if;

  end process COUNTING;

  STORING:
  process (reset, clk)
  begin
    -- Asynchronous reset
    if(reset = '1') then
      count <= std_logic_vector(n-1 downto 0) := (others => 0);
    elsif rising_edge(CLK) then
      count <= std_logic_vector(count_i);
    end if;
  end process STORING;

  -- Concurrent signal assignment
  Max_count <= '1' when count = max and up = '1' else '0';
  Min_count <= '1' when count = min and up = '0' else '0'; 

end beh;
