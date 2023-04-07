library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use  STD.textio.all;
library work;

entity self_test_module is
  generic(
              data_width: natural := 8; 
              addr_width: natural := 5; 
              filename: string := "rom_data.txt"
            );

  port(
      mclk          : in std_logic;
      reset         : in std_logic;
      duty_cycle    : out std_logic_vector(data_width-1 downto 0) --:= "00000";
    );
end self_test_module;

architecture rtl of self_test_module is
  

  -- Counter specific signals
  signal count_reg : integer := 0; -- With the clock oscilator at 100 MHz, we have to count to 300 000 000
  signal count_next : integer;

  -- Other signals
  signal second_tick : std_logic;
  
  -- ROM 
  type ROM is array(2**addr_width-1 downto 0) of std_logic_vector(data_width-1 downto 0); 
  signal c_addr: integer := 0;  
  signal c_addr_next: integer := 0; 

  impure function file_length(file_name: string) return natural is 
    file data_file : text open read_mode is file_name;
    variable c_line: line; 
    variable length: natural := 0; 
  begin 
    while not endfile(data_file) loop
      readline(data_file, c_line); 
      length := length + 1;
    end loop; 
    file_close(data_file); 
    return length;
  end function;

  constant rom_size: natural := file_length(filename); 

  impure function init_ROM(file_name: string) return ROM is 
    file data_file : text open read_mode is file_name; 
    variable c_line: line; 
    variable out_rom: ROM; 
  begin 
    for i in 0 to rom_size-1 loop
      readline(data_file, c_line); 
      read(c_line, out_rom(i)); 
    end loop; 
    file_close(data_file);
    return out_rom; 
  end function; 

  constant ROM_DATA: ROM := init_ROM(filename); 
  signal data_out: std_logic_vector(data_width-1 downto 0) := ROM_DATA(c_addr); 

begin

  COUNTING:
  process (count_reg)
  begin
    count_next <= count_reg + 1;
  end process COUNTING;

  process(all)
  begin
    duty_cycle <= data_out; 
    if reset = '1' then
      count_reg <= 0;
      c_addr <= 0;
    
    elsif c_addr_next >= rom_size then 
      duty_cycle <= "00000000"; 

    elsif rising_edge(mclk) then
      if second_tick = '1' then  -- 100 MHz clock / 50 Hz frequency = 2 * 1e6 cycles */
        duty_cycle <= data_out;

        c_addr <= c_addr_next when c_addr_next < rom_size else 0;  

        count_reg <= 0;

      else
        count_reg <= count_next; 
      end if; 
   
    end if;
  end process;

  ADDRESS_READ: 
  process (c_addr)
  begin
    c_addr_next <= c_addr + 1; 
    data_out <= ROM_DATA(c_addr);
  end process ADDRESS_READ;
 
  second_tick <= '1' when count_reg = 300000000 else '0'; 
  
end architecture;

