library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

package utility is 

  function bin2ssd(bin: std_logic_vector(4 downto 0)) return std_logic_vector;

end package utility; 

package body utility is 

  function bin2ssd(bin: std_logic_vector(4 downto 0)) return std_logic_vector is 
    variable abcdefg: std_logic_vector(6 downto 0);  
    begin 
      case bin(4 downto 0) is 
        when "00000" => abcdefg := "1111110"; 
        when "00001" => abcdefg := "0110000"; 
        when "00010" => abcdefg := "1101101"; 
        when "00011" => abcdefg := "1111001"; 
        when "00100" => abcdefg := "0110011"; 
        when "00101" => abcdefg := "1011011"; 
        when "00110" => abcdefg := "1011111"; 
        when "00111" => abcdefg := "1110000"; 
        when "01000" => abcdefg := "1111111"; 
        when "01001" => abcdefg := "1110011";     
        when "01010" => abcdefg := "1110111"; 
        when "01011" => abcdefg := "0011111"; 
        when "01100" => abcdefg := "1001110"; 
        when "01101" => abcdefg := "0111101"; 
        when "01110" => abcdefg := "1001111";
        when "01111" => abcdefg := "1000111";
        when "10000" => abcdefg := "0000000";
        when "10001" => abcdefg := "0011110";
        when "10010" => abcdefg := "0111100";
        when "10011" => abcdefg := "1001111";
        when "10100" => abcdefg := "0001110";
        when "10101" => abcdefg := "0111101"; 
        when "10110" => abcdefg := "0011101"; 
        when "10111" => abcdefg := "0010101"; 
        when "11000" => abcdefg := "0111011"; 
        when "11001" => abcdefg := "0111110"; 
        when "11010" => abcdefg := "1110111"; 
        when "11011" => abcdefg := "0000101"; 
        when "11100" => abcdefg := "1111011"; 
        when "11101" => abcdefg := "0011100";
        when "11110" => abcdefg := "0001101"; 
        when "11111" => abcdefg := "0001111"; 
        when others => abcdefg := "0000000";
    end case; 
    return abcdefg;
  end; 

end package body utility;
