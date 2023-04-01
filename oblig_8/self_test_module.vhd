library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use  STD.textio.all;
library work;

entity self_test_module is
  generic(
              data_width: natural := 10; 
              addr_width: natural := 4; 
              rom_size  : natural := 10;
              filename: string := "rom_data.txt"
            );

  port(
      mclk          : in std_logic;
      reset         : in std_logic;
      duty_cycle    : out signed(data_width-1 downto 0) --:= "00000";
    );
end self_test_module;

architecture rtl of self_test_module is
  

  -- Counter specific signals
  signal count_reg : integer := 0;
  signal count_next : integer;

  -- Other signals
  signal second_tick : std_logic;
  
  -- ROM 
  type ROM is array(rom_size downto 0) of signed(data_width-1 downto 0); 
  signal c_addr: integer := 0;  
  signal c_addr_next: integer := 0; 

  impure function init_ROM(file_name:string) return ROM is 
    file data_file : text open read_mode is file_name; 
    variable c_line: line; 
    variable out_rom: ROM; 
  begin 
    for i in 0 to rom_size loop
      readline(data_file, c_line); 
      read(c_line, out_rom(i)); 
    end loop; 
    return out_rom; 
  end function; 

  constant ROM_DATA: ROM := init_ROM(filename); 

  signal data_out: signed(data_width-1 downto 0) := ROM_DATA(c_addr); 

begin

  COUNTING:
  process (all)
  begin
    count_next <= count_reg + 1;
  end process COUNTING;

  process(mclk, reset)
  begin

    if reset = '1' then
      count_reg <= 0;
      c_addr <= 0;

    elsif c_addr > rom_size then 
      c_addr <= 0; 

    elsif rising_edge(mclk) then
      if second_tick = '1' then  -- 100 MHz clock / 50 Hz frequency = 2 * 1e6 cycles */
        duty_cycle <= data_out;
        c_addr <= c_addr_next; 
        count_reg <= 0;
      else
        count_reg <= count_next; 
      end if;
    else 
      duty_cycle <= data_out; 
    end if;
  end process;

  ADDRESS_READ: 
  process (c_addr)
  begin
    c_addr_next <= c_addr + 1;
    data_out <= ROM_DATA(c_addr);
  end process ADDRESS_READ;
 
  second_tick <= '1' when count_reg = 10 else '0'; 
  
end architecture;

