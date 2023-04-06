 library IEEE; 
 use IEEE.std_logic_1164.all; 
 use IEEE.numeric_std.all; 

entity pulse_subsystem is 
  port( 
    clk         : in std_logic; 
    reset       : in std_logic; 
    dir_synch   : out std_logic; 
    en_synch    : out std_logic
  );
end pulse_subsystem;

