library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all;
library work;

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

architecture struct of self_test_unit is
  

  -- Counter specific signals
  signal s_count : integer := 10;
  signal s_count_i : integer;

  -- Other signals
  signal second_tick : std_logic;
  
  -- ROM 
  type ROM is array(2**addr_width-1 downto 0) of std_logic_vector(data_width-1 downto 0); 
  signal c_addr: unsigned(addr_width-1 downto 0) := "0001";  


  impure function init_ROM(file_name:string) return ROM is 
    file data_file : text open read_mode is file_name; 
    variable c_line: line; 
    variable out_rom: ROM; 
  begin 
    for i in 0 to out_rom'length-1 loop 
      readline(data_file, c_line); 
      read(c_line, out_rom(i)); 
    end loop; 
    return out_rom; 
  end function; 

  constant ROM_DATA: ROM := init_ROM(filename); 

  signal data_out: std_logic_vector(data_width-1 downto 0) := ROM_DATA(to_integer(c_addr-1));
  
  component counter
    port(
        clk      : in std_logic;
        reset    : in std_logic;
        count_i  : out integer;
        count_o  : out integer
      );
  end component;
  
  component clock_divider
    port(
        clk      : in std_logic;
        div_i    : in integer;
        div_o    : out std_logic
      );
  end component;

  component rom_reader
    port(
        addr_i   : in unsigned(addr_width-1 downto 0);
        data_o   : out std_logic_vector(data_width-1 downto 0)
      );
  end component;

  component data_splitter
    port(
        data_i   : in std_logic_vector(data_width-1 downto 0);
        data_o0  : out std_logic_vector(data_width/2-1 downto 0);
        data_o1  : out std_logic_vector(data_width/2-1 downto 0)
      );
  end component;

begin

  COUNTING: counter port map(mclk, reset, s_count_i, s_count);

  DIVIDER: clock_divider port map(mclk, 10, second_tick);

  ROM_R: rom_reader port map(c_addr, data_out);

  SPLITTER: data_splitter port map(data_out, d0, d1);
  
end architecture struct;

