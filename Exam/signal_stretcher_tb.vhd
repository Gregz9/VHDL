library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.stop;

entity signal_stretcher_tb is 
end entity signal_stretcher_tb; 

architecture behavioral of signal_stretcher_tb is 

  procedure send_pulse(
    signal clk : in std_logic; 
    signal test_vector : in std_logic_vector; 
    signal x           : out std_logic; 
  ) is
  begin 
    for i in test_vector'range loop
      wait until rising_edge(clk); 
      x <= test_vector(i);
    end loop; 
  end procedure;

  component s
