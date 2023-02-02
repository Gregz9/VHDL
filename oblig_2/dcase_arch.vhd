
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

architecture Dcase of Dec24 is 

begin  
    process(all) begin 
        case sw is 
            when "00" => led <= "1110";
            when "01" => led <= "1101"; 
            when "10" => led <= "1011"; 
            when "11" => led <= "0111"; 
	    when others => led <= "0000";
        end case; 
    end process; 
end Dcase; 
