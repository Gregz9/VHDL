library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use STD.textio.all;
library work; 

entity tb_self_test_unit is 
end tb_self_test_unit;

architecture rtl of tb_self_test_unit is

  signal tb_clk        : std_logic := '0';
  signal tb_reset      : std_logic := '0'; 
  signal tb_d0         : std_logic_vector(4 downto 0); 
  signal tb_d1         : std_logic_vector(4 downto 0);


  type ROM is array(2**4-1 downto 0) of std_logic_vector(9 downto 0); 

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

  constant ROM_DATA: ROM := init_ROM("secret_data.txt"); 
  signal out_data: std_logic_vector(9 downto 0) := "0000000000" ;


begin 
  UUT : entity work.self_test_unit(beh) port map(tb_clk, tb_reset, tb_d0, tb_d1);

  P_CLK_0: process
    begin 
      tb_clk <= '0'; 
      wait for 10 ns; 
      tb_clk <= '1';
      wait for 10 ns; 
    end process P_CLK_0;
 
  process begin
    wait for 10 ns;
    for i in 0 to ROM_DATA'length-1 loop
    out_data <= ROM_DATA(to_integer(to_unsigned(i, 4)));
    assert(tb_d1 = out_data(9 downto 5) and tb_d0 = out_data(4 downto 0))
    report ("Wrong sequence output") severity failure;
    if i = 15 then 
    wait for 210 ns; 
    else 
    wait for 220 ns; 
  end if;
  end loop;
  report ("Test successful");
  /* std.env.stop(0); */
end process; 
end rtl; 

