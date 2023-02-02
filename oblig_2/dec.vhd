

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity Dec is
    generic(n : integer := 2);
    port 
        ( 
            inp  :   in std_logic_vector(n-1 downto 0); 
            outp :   out std_logic_vector(2**n -1 downto 0)

        ); 
end Dec; 

architecture Dec_Arch of Dec is 

begin  
    process(inp) begin 
        case inp is 
            when "00" => outp <= "1110";
            when "01" => outp <= "1101"; 
            when "10" => outp <= "1011"; 
            when "11" => outp <= "0111"; 
	    when others => outp <= "0000";
        end case; 
    end process; 
end Dec_Arch; 

