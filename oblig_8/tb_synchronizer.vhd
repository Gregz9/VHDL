library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use STD_textio.all; 
library work;
use work.all; 

entity tb_synchronizer is 
  generic(
          tb_data_width: natural := 10; 
          tb_addr_width: natural := 5;
          tb_filename  : string := "output_synch_data.txt";
          );
end tb_synchronizer; 

architecture behavioral of tb_self_test_module is
 
  -- Component declaration
  component self_test_module
    port
      (
        mclk        : in std_logic; 
        reset       : in std_logic; 
        duty_cycle  : out signed(tb_data_width-1 downto 0)
      ); 
  end component self_test_module; 

  component pulse_width_modulator 
    port 
      (
        mclk        : in std_logic; 
        reset       : in std_logic; 
        duty_cycle  : in std_logic_vector;
        dir         : out std_logic; 
        en          : out std_logic
      );
  end component pulse_width_modulator; 

  component brute_synchronizer 
    port 
      (
        clk         : in std_logic; 
        reset       : in std_logic; 
        signal_a    : in std_logic; 
        signal_b    : in std_logic; 
        synch_signal_a : out std_logic; 
        synch_signal_b : out std_logic
      ); 
  end component brute_synchronizer;

  signal tb_clk         : std_logic := 0; 
  signal tb_reset       : std_logic := 0; 
  signal tb_duty_cycle  : signed(tb_data_width-1 downto 0);
  signal tb_dir         : std_logic; 
  signal tb_en          : std_logic; 
  signal synch_dir      : std_logic; 
  signal synch_en       : std_logic; 

  type ROM is array(2**tb_addr_width-1 downto 0) of std_logic_vector(1 downto 0); 
  
  impure function file_length(filename: string) return natural is 
    file data_file : text open read_mode is tb_filename; 
    variable c_line: line; 
    variable length: integer := 0; 
  begin 
    while not endfile(data_file) loop
      readline(data_file, c_line); 
      length := length + 1;
    end loop; 
    file_close; 
    return length; 
  end function; 

  signal length_file : natural := file_length(tb_filename);

  impure function init_ROM(file_name: string, len: natural) return ROM is 
    file data_file : text open read_mode is file_name; 
    variable c_line : line; 
    variable out_rom : ROM;
    begin 
      for i in 0 to len-1 loop 
        readline(data_file, c_line); 
        read(c_line, out_rom(i));
      end loop;
      file_close(data_file);
      return out_rom;
    end function;

  constant SYNCH_ROM : ROM := init_ROM(tb_filename, length_file);

  begin 

  -- Instatiate components

    CLOCK: process
    begin 
      tb_clk <= '0'; 
      wait for 5 ns; 
      tb_clk <= '1'; 
      wait for 5 ns; 
    end process CLOCK; 

    

  








