library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity Dec24 is
    generic(n : integer := 2);
    port 
        ( 
            sw  :   in std_logic_vector(n-1 downto 0); 
            led :   out std_logic_vector(2**n -1 downto 0)

        ); 
end Dec24; 
