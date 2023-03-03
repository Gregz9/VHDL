library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
library work; 
use work.conv_bin_sig.all; 

entity tb_seg7model is 
end tb_seg7model; 

architecture rtl of tb_seg7model is
    
    signal bin: std_logic_vector(4 downto 0) := "00000"; 
	-- UUT Signals
    signal tb_c           : std_logic := '1';
    signal tb_abcdefg     : std_logic_vector(6 downto 0) := "0000000"; 
    signal tb_disp1       : std_logic_vector(4 downto 0); 
    signal tb_disp0       : std_logic_vector(4 downto 0); 
  
begin
    -- UUT initation
    UUT : entity work.seg7model(beh) port map(tb_c, tb_abcdefg, tb_disp1, tb_disp0); 

    process begin
      for i in std_logic range '0' to '1' loop 
        tb_c <= i;
        wait for 10 ns;
        for j in 0 to 31 loop
          bin <= std_logic_vector(to_unsigned(j, 5));
          tb_abcdefg <= bin2ssd(bin); 
          wait for 10 ns; 
        end loop; 
      end loop; 
      std.env.stop(0); 
    end process;
end rtl;


       
