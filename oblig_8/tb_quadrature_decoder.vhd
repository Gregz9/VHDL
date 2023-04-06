library IEEE; 
use IEEE.std_logic_1164.all; 
library work; 
library work.all; 


entity tb_quadrature_decoder is 
end entity tb_quadrature_decoder;

architecture behavioral of tb_quadrature_decoder is 

-- Component declaration
  component input_synchronizer
    port(
      clk         : in std_logic; 
      reset       : in std_logic;
      signal_a    : in std_logic; 
      signal_b    : in std_logic;  
      synch_signal_a : out std_logic; 
      synch_signal_b : out std_logic
      ); 
  end component input_synchronizer; 

  component quadrature_decoder
    port( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      synch_a   : in std_logic; 
      synch_b   : in std_logic; 
      pos_inc   : out std_logic; 
      pos_dec   : out std_logic
      ); 
  end component quadrature_decoder;
  
  signal tb_clk : std_logic; 
  signal tb_reset : std_logic; 
  signal encoded_a : std_logic := 0; 
  signal encoded_b : std_logic := '0';
  signal tb_synch_a : std_logic; 
  signal tb_synch_b : std_logic;
  signal tb_pos_inc : std_logic; 
  signal tb_pos_dec : std_logic; 

begin 

  encoded_a <= not encoded_a after 7 ns; 
  encoded_b <= not encoded_b after 15 ns; 

  SYNCH : input_synchronizer
  port map 
      (
        clk => tb_clk, 
        reset => tb_reset, 
        signal_a => encoded_a, 
        signal_b => encoded_b, 
        synch_signal_a => tb_synch_a,
        synch_signal_b => tb_synch_b
      );

  QUAD : quadrature_decoder 
  port map
      ( 
        clk => tb_clk, 
        reset => tb_reset, 
        synch_a => tb_synch_a, 
        synch_b => tb_synch_b, 
        pos_inc => tb_pos_inc, 
        pos_dec => tb_pos_dec
      ); 
  
  CLOCK: process 
  begin 
    tb_clk <= '0'; 
    wait for 5 ns; 
    tb_clk <= '1'; 
    wait for 5 ns; 
  end process CLOCK; 

end behavioral; 

