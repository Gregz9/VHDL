library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
use std.textio.all; 

entity ROM is 
  generic map( 
              data_wdith: natural := 8;
              addr_width: natural := 4; 
              filename: string := "secret_data.txt"
            );
  port( 
      address: in std_logic_vector(addr_width-1 downto 0);
      data: out std_logic_vector(data_width-1 downto 0)
    ); 
end entity; 

architecture beh of ROM is 
  -- setting rom data_type 
  type memory_array is array(2**addr_width-1 downto 0) of std_logic_vector(data_width-1 downto 0);

  impure function initialize_ROM(file_name: string) return memory_array is 
    file data_file: text open read_mode is file_name; 
    variable C_line: line;
    variable out_rom: memory_array; 
  begin 
    for i in out_rom'range loop
      readline(data_file, c_line);
      read(c_line, out_rom(i));
    end loop; 
    return out_rom;
    end_function; 

    contant_ROM_DATA: memory_array := initialize_ROM(filename);

begin 
  data <= ROM_DATA(to_integer(unsigned(address)));
end; 
end architecture;
               
