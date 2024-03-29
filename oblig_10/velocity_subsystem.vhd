library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
library work; 
use work.all;

entity velocity_subsystem is 
  port( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      SA        : in std_logic; 
      SB        : in std_logic; 
      abcdefg   : out std_logic_vector(6 downto 0); 
      c         : out std_logic; 
      synch_velocity : out signed(7 downto 0); 
    );
end entity velocity_subsystem;

architecture structural of velocity_subsystem is 

-- component declaration
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

  component velocity_reader
    port(
      mclk      : in std_logic; 
      reset     : in std_logic; 
      pos_inc   : in std_logic; 
      pos_dec   : in std_logic; 
      velocity  : out signed(7 downto 0)
       );
    end component velocity_reader;

  component seg7ctrl 
    port( 
      mclk      : in std_logic; 
      reset     : in std_logic; 
      velocity  : in signed(7 downto 0); 
      abcdefg   : out std_logic_vector(6 downto 0); 
      c         : out std_logic
      );
    end component seg7ctrl; 

  component velocity_synchronizer  
    port( 
      clk	: in std_logic; 
      reset 	: in std_logic; 
      velocity  : in signed(7 downto 0);
      synch_velocity: out signed(7 downto 0)
      );
  end component velocity_reader;
  
  signal sub_synch_a : std_logic; 
  signal sub_synch_b : std_logic;
  signal sub_pos_inc : std_logic; 
  signal sub_pos_dec : std_logic;
  signal sub_velocity: signed(7 downto 0); 

begin 
  
  SYNCH : input_synchronizer 
  port map(
        clk => clk,
        reset => reset, 
        signal_a => SA, 
        signal_b => SB, 
        synch_signal_a => sub_synch_a, 
        synch_signal_b => sub_synch_b 
      ); 

  QUAD : quadrature_decoder
  port map(
        clk => clk,
        reset => reset, 
        synch_a => sub_synch_a,
        synch_b => sub_synch_b, 
        pos_inc => sub_pos_inc,
        pos_dec => sub_pos_dec
      );

  VEL : velocity_reader 
  port map(
        mclk => clk, 
        reset => reset, 
        pos_inc => sub_pos_inc, 
        pos_dec => sub_pos_dec,
        velocity => sub_velocity
      );

  VEL_SYNCH : velocity_synchronizer 
  port map( 
        clk => clk, 
        reset => reset, 
        velocity => sub_velocity, 
        synch_velocity => synch_velocity
      ); 
        

  SEG7 : seg7ctrl 
  port map(
        mclk => clk, 
        reset => reset, 
        velocity => sub_velocity, 
        abcdefg => abcdefg,
        c => c
      );

end architecture structural;
        



