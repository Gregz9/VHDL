library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use STD.textio.all;
library work; 

entity tb_self_test_module is 
  generic(
            tb_data_width: natural := 8; 
            tb_addr_width: natural := 5;
            tb_filename: string := "rom_data.txt"
            /* tb_rom_size  : natural := 21 */
          );  
end tb_self_test_module;

architecture rtl of tb_self_test_module is

  signal tb_clk        : std_logic := '0';
  signal tb_reset      : std_logic := '0'; 
  signal tb_duty_cycle : signed(tb_data_width-1 downto 0); 

  type ROM is array(2**tb_addr_width-1 downto 0) of signed(tb_data_width-1 downto 0); 
  
  impure function file_length(filename: string) return integer is
    file data_file : text open read_mode is filename; 
    variable c_line: line; 
    variable length: integer := 0;
    begin 
      while not endfile(data_file) loop
      readline(data_file, c_line); 
      length := length + 1; 
    end loop; 
    file_close(data_file);
    return length; 
  end function; 

  signal elements : integer := file_length(tb_filename);

  impure function init_ROM(file_name:string) return ROM is 
    file data_file : text open read_mode is file_name; 
    variable c_line: line; 
    variable out_rom: ROM; 
    begin 
      for i in 0 to elements-1 loop
      readline(data_file, c_line); 
      read(c_line, out_rom(i)); 
    end loop; 
    file_close(data_file);
    return out_rom; 
  end function; 

  constant ROM_DATA: ROM := init_ROM(tb_filename); 
  signal out_data: signed(tb_data_width-1 downto 0) := ROM_DATA(0);


begin 
  UUT : entity work.self_test_module(rtl) generic map(tb_data_width, tb_addr_width, elements, tb_filename) port map(tb_clk, tb_reset, tb_duty_cycle);
  
  /* tb_reset <= '1', '0' after 10 ns; */
  P_CLK_0: process
    begin 
      tb_clk <= '0'; 
      wait for 5 ns; 
      tb_clk <= '1';
      wait for 5 ns; 
    end process P_CLK_0;
 
  process begin
    for i in 0 to elements-1 loop
      out_data <= ROM_DATA(i); -- ROM_DATA(to_integer(to_unsigned(i, 5)));
      wait for 5 ns; 
      assert(tb_duty_cycle = out_data)
      report ("Wrong sequence output") severity error;
      wait for 105 ns;
    end loop;
    wait for 220 ns; 
    assert(tb_duty_cycle = "00000000")
    report ("Fucking wrong!") severity failure;
    report ("Test successful");
   std.env.stop(0); 
end process; 
end rtl; 

