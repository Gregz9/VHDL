library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use IEEE.float_pkg.all; 

entity pulse_width_modulator is 
  generic( 
          PWM_frequency: natural := 2000; -- in Hz
          ); 

  port( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      duty_cycle: in signed(7 downto 0); 
      dir       : out std_logic := 0; 
      en        : out std_logic := '0';
    ); 
end pulse_width_modulator; 

architecture rtl of pulse_width_modulator is 
  
  constant PWM_count : integer := 100000000 / desired_frequency; 
  constant max_value : integer := 127; 
  /* signal percentage : float(32, 8);  */
  
  signal PWM_high : integer := 0; 
  signal count_reg : integer := 0; 
  signal count_next: integer := 0; 

begin 

  COUNTING: 
  process(count_reg) 
  begin 
    count_next <= count_reg + 1; 
  end process COUNTING; 


  DIRECTION:
  process(duty_cycle)
  begin 
    if to_integer(duty_cycle) > 0 then  
      dir <= '1'; 
      en <= '1'; 
      PWM_high <= ROUND_TO_NEAREST(abs(to_integer(duty_cycle))/max_value)*PWM_count
    elsif to_integer(duty_cycle) < 0 then
      dir <= '0'; 
      en <= '1'; 
      PWM_high <= ROUND_TO_NEAREST(abs(to_integer(duty_cycle))/ -max_value )*PWM_count
    elsif to_integer(duty_cycle) = 0 then 
      dir <= '0'; 
      en <= '0'; 
      PWM_high <= '0'; 
    end if; 
  end process DIRECTION; 

  REGISTERS: 
  process(clk, reset) 
  begin 
    if reset = '1' then 
      count_reg <= 0; 
      dir <= '0'; 
      en <= '0'; 
    elsif count_next < PWM_count then 
      count_reg <= 0; 
    elsif rising_edge(clk) then 
      if count_next <= PWM_high then 
        count_reg <= count_next;
      else 
        count_reg <= count_next; 
        en <= '0';
      end if; 
    end if; 
  end process REGISTERS; 

end architecture;






