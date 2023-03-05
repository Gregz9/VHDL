library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use  STD.textio.all;

entity self_test_unit is
  generic(
              data_width: natural := 10; 
              addr_width: natural := 4; 
              filename: string := "secret_data.txt"
            );

  port(
      mclk      : in std_logic;
      reset     : in std_logic;
      d0        : out std_logic_vector(4 downto 0) := "00000";
      d1        : out std_logic_vector(4 downto 0) := "00000"
    );
end self_test_unit;

architecture beh of self_test_unit is
  
  signal data_out: std_logic_vector(data_width-1 downto 0) := "0000000000";
  signal data_0: std_logic_vector((data_width/2)-1 downto 0) := "00000";
  signal data_1: std_logic_vector((data_width/2)-1 downto 0) := "00000";

  -- Counter specific signals
  signal s_count : integer := 0;
  signal s_count_i : integer;

  -- Other signals
  signal second_tick : std_logic := '0';
  
  -- ROM 
  type memory_array is array(2**addr_width-1 downto 0) of std_logic_vector(data_width-1 downto 0); 
  signal c_addr: unsigned(addr_width-1 downto 0) := "0000";  

  impure function init_ROM(file_name:string) return memory_array is 
    file data_file : text open read_mode is file_name; 
    variable c_line: line; 
    variable out_rom: memory_array; 
  begin 
    for i in 0 to out_rom'length-1 loop 
      readline(data_file, c_line); 
      read(c_line, out_rom(i)); 
    end loop; 
    return out_rom; 
  end function; 

  constant ROM_DATA: memory_array := init_ROM(filename); 


begin

  COUNTING:
  process (all)
  begin
    s_count_i <= s_count + 1;
  end process COUNTING;

  process(mclk, reset)
  begin
    if reset = '1' then
      s_count <= 0;
      d1 <= "00000";
      d0 <= "00000";
    elsif rising_edge(mclk) then
      if s_count = 10 then  -- 100 MHz clock / 50 Hz frequency = 2 * 1e6 cycles */
        data_out <= ROM_DATA(to_integer(c_addr));
        d1 <= data_out(data_width-1 downto data_width/2); 
        d0 <= data_out((data_width/2)-1 downto 0);
        s_count <= 0;
        c_addr <= c_addr + 1; 
      else
        s_count <= s_count + 1;
      end if;
    end if;
  end process;

end architecture;

