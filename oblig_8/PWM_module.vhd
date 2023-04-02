library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use IEEE.float_pkg.all; 

entity pulse_width_modulator is 
  generic( 
          PWM_frequency: natural := 2000 -- in Hz
          ); 

  port( 
      mclk       : in std_logic; 
      reset     : in std_logic; 
      duty_cycle: in std_logic_vector(7 downto 0); 
      dir       : out std_logic := '0';
      en        : out std_logic := '1'
    ); 
end pulse_width_modulator; 

architecture rtl of pulse_width_modulator is 
  
  constant PWM_count : integer := 100000000 / PWM_frequency; 
  constant max_value : integer := 128; 
  
  signal PWM_high : integer := 0; 
  signal count_reg : integer := 0; 
  signal count_next: integer := 0; 
  signal new_dir : std_logic; 

begin 

  COUNTING: 
  process(count_reg) 
  begin 
    count_next <= count_reg + 1; 
  end process COUNTING; 


  DIRECTION:
  process(duty_cycle, mclk)
  begin 
    
    if to_integer(signed(duty_cycle)) > 0 then 
      PWM_high <= (to_integer(unsigned(duty_cycle))/max_value)*PWM_count;
      new_dir <= '1'; 
    else 
      PWM_high <= abs(to_integer(unsigned(duty_cycle))/max_value)*PWM_count;
      new_dir <= '0';
    end if;

    if reset = '1' then 
      en <= '0';
      dir <= '0';

    elsif rising_edge(mclk) then 
      if dir /= new_dir and en = '1' then  
        en <= '0';
      elsif dir /= new_dir and en = '0' then 
        dir <= new_dir;
      elsif dir = new_dir and en = '0' then 
        en <= '1'; 
      end if; 
      

    end if; 
  end process DIRECTION; 
  

  REGISTERS: 
  process(mclk, reset) 
  begin 
    if reset = '1' then 
      count_reg <= 0; 
    elsif count_next > PWM_count then 
      count_reg <= 0; 
    elsif rising_edge(mclk) then 
      if count_next <= PWM_high then 
        count_reg <= count_next;
      else 
        count_reg <= count_next; 
      end if; 
    end if; 
  end process REGISTERS; 

end architecture;






