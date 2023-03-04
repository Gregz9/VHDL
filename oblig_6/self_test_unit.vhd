library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;
use STD.textio.all; 

entity self_test_unit is 
  port( 
      mclk      : in std_logic; 
      reset     : in std_logic; 
      d0        : out std_logic_vector(4 downto 0); 
      d1        : out std_logic_vector(4 downto 0)
    ); 
end entity seld_test_unit; 

architecture beh of self_test_unit is 
  
  file secret_message : text open READ_MODE is "secred_data.txt";
  variable dline : line; 

  signal data_0 : std_logic_vector(4 downto 0); 
  signal data_1 : std_logic_vector(4 downto 0); 

  -- Counter specific signals
  signal s_count : integer := 0; 
  signal s_count_i : integer; 
  
  -- Other signals
  signal second_tick : std_logic := '0'; 


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
      if c_count = 10 then  -- 100 MHz clock / 50 Hz frequency = 2 * 1e6 cycles
        readline(secret_message, dline);
        read(dline, data_1, data_0);
        d1 <= data_1; 
        d0 <= data_0; 
        c_count <= 0;  
      end if;
    end if;
  end process; 

end architecture;
