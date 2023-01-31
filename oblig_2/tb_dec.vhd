

library ieee; 
use ieee.std_logic_1164.all; 
use std.env.stop; 

entity Test_Dec is 
    -- empty entity
end Test_Dec; 

architecture Test of Test_Dec is 
    signal tb_sw : std_logic_vector(1 downto 0);
    singal tb_led : std_logic_vector(3 downto 0); 
begin 
    -- Device under test 
    DUT :   Dec 
        port map
        ( 
            inp     => tb_inp,
            outp    => tb_outp 
        );
    
    process begin 
    for i in 0 to 3 loop
        tb_inp <= std_logic_vector(to_unsigned(i, 2));
        wait for 10 ns; 
    end loop;  
    std.env.stop(0);
    end process; 
end Test;