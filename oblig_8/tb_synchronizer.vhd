library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use STD.textio.all; 
library work;
use work.all; 

entity tb_synchronizer is 
  generic(
          tb_data_width: natural := 8; 
          tb_addr_width: natural := 5;
          tb_filename_synch  : string := "output_synch_data.txt";
          tb_filename_test   : string := "rom_data.txt"
          );
end tb_synchronizer; 

architecture behavioral of tb_synchronizer is
 
  -- Component declaration
  component self_test_module
    generic
      ( 
        data_width: natural := 10; 
        addr_width: natural := 4; 
        filename: string := "rom.txt"
      );
    port
      (
        mclk        : in std_logic; 
        reset       : in std_logic; 
        duty_cycle  : out std_logic_vector(tb_data_width-1 downto 0)
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

  component output_synchronizer 
    port 
      (
        clk         : in std_logic; 
        reset       : in std_logic; 
        signal_a    : in std_logic; 
        signal_b    : in std_logic; 
        synch_signal_a : out std_logic; 
        synch_signal_b : out std_logic
      ); 
  end component output_synchronizer;

  signal tb_clk         : std_logic := '0'; 
  signal tb_reset       : std_logic := '0'; 
  signal tb_duty_cycle  : std_logic_vector(tb_data_width-1 downto 0);
  signal tb_dir         : std_logic; 
  signal tb_en          : std_logic; 
  signal synch_dir      : std_logic; 
  signal synch_en       : std_logic; 

  type ROM is array(2**tb_addr_width-1 downto 0) of std_logic_vector(tb_data_width-1 downto 0); 
  
  impure function file_length(filename: string) return natural is 
    file data_file : text open read_mode is filename; 
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


  signal length_file : natural := file_length(tb_filename_synch);

  begin 

  -- Instatiate components
  SLFT : self_test_module
  generic map
        (
          data_width => tb_data_width,
          addr_width => tb_addr_width, 
          filename => tb_filename_test
        ) 
  port map
        (
        mclk => tb_clk, 
        reset => tb_reset, 
        duty_cycle => tb_duty_cycle 
        );

  PWM : pulse_width_modulator
  port map
        (
        mclk => tb_clk, 
        reset => tb_reset, 
        duty_cycle => tb_duty_cycle, 
        dir => tb_dir, 
        en => tb_en
        );

  SYNCH : output_synchronizer 
  port map
        (
        clk => tb_clk, 
        reset => tb_reset, 
        signal_a => tb_dir, 
        signal_b => tb_en, 
        synch_signal_a => synch_dir, 
        synch_signal_b => synch_en
      );

    CLOCK: process
    begin 
      tb_clk <= '0'; 
      wait for 5 ns; 
      tb_clk <= '1'; 
      wait for 5 ns; 
    end process CLOCK; 

end behavioral;

    

  








