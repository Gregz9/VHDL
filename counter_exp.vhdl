library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 

entity FIRST is 
    port
        ( 
            clk         : in    std_logic; 
            reset       : in    std_logic; 
            load        : in    std_logic; 
            inp         : in    std_logic_vector(3 downto 0); 
            count       : out   std_logic_vector(3 downto 0); 
            max_count   : out   std_logic
        );
end FIRST; 

architecture MY_FIRST_ARCH of FIRST is 

    signal count_i  :   unsigned(3 downto 0); 

begin 

    COUNTING: 
    process (all)
    begin 
        if load <= '1' then 
            count_i <= unsigned(inp)
        else
            count_i <= unsigned(count) + 1;
        end if;
    end process COUNTING;
    
    STORING: 
    process (reset, clk)
    begin 
        if(reset = '1') then 
            count <= '0000';
        elsif rising_edge(CLK) then 
            count <= std_logic_vector(count_i);
        end if;
    end process STORING;

    max_count <= '1' when count = '1111' else 0; 

end MY_FIRST_ARCH; 