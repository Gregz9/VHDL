
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use std.env.stop; 

entity Test_Dec is 
    -- empty entity
end Test_Dec; 

architecture Test of Test_Dec is 
    signal tb_sw1, tb_sw2 : std_logic_vector(1 downto 0);
    signal tb_led1, tb_led2 : std_logic_vector(3 downto 0); 
begin
     DUT1 : entity work.Dec24(Dselect) port map(tb_sw1, tb_led1);
     DUT2 : entity work.Dec24(Dcase) port map(tb_sw2, tb_led2);

process begin 
    for i in 0 to 3 loop
        tb_sw1 <= std_logic_vector(to_unsigned(i, 2));
	tb_sw2 <= std_logic_vector(to_unsigned(i, 2));
        wait for 10 ns; 
    end loop;  
    std.env.stop(0);
    end process; 
end Test;
