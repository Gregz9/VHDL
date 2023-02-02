
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

architecture Dselect of Dec24 is 

begin  
    with sw select
        led <=  "1110" when "00", 
                "1101" when "01",
                "1011" when "10",
                "1111" when "11",
                "0000" when others;
end Dselect; 
