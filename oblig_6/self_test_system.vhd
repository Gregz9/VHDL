library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use STD.textio.all; 
library work; 

entity self_test_system is 
  port ( 
      mclk      : in std_logic; 
      reset     : in std_logic; 
      abcdefg   : out std_logic_vector(6 downto 0); 
      c         : out std_logic
    ); 
end entity self_test_system; 

architecture mixed of self_test_system is 
  
  signal data_0 : std_logic_vector(4 downto 0); 
  signal data_1 : std_logic_vector(4 downto 0); 
    

  component self_test_unit 
    port(
        mclk    : in std_logic; 
        reset   : in std_logic; 
        d0      : out std_logic_vector(4 downto 0); 
        d1      : out std_logic_vector(4 downto 0)
      ); 
  end component; 

  component seg7ctrl is 
    port( 
        mclk    : in std_logic; 
        reset   : in std_logic; 
        d0      : in std_logic_vector(4 downto 0); 
        d1      : in std_logic_vector(4 downto 0); 
        abcdefg : out std_logic_vector(6 downto 0); 
        c       : out std_logic
      ); 
  end component; 

  begin 

    SELF_UNIT: entity work.self_test_unit(beh) port map(mclk, reset, data_0, data_1);

    SEG_CTRL: entity work.seg7ctrl(beh) port map(mclk, reset, data_0, data_1, abcdefg, c);

end architecture mixed; 
