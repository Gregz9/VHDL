library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 

entity pulse_width_modulator is 

  port( 
      mclk      : in std_logic; 
      reset     : in std_logic; 
      duty_cycle: in std_logic_vector(7 downto 0); 
      dir       : out std_logic;
      en        : out std_logic 
    ); 
end pulse_width_modulator; 

architecture rtl of pulse_width_modulator is 
  
  type state_type is (reverse_idle, forward_idle, reverse, forward);
  signal current_state, next_state : state_type;

  signal count_reg, count_next : unsigned(15 downto 0) := (others => '0');  
  signal PWM : std_logic := '0';

begin 

  COUNTING: 
  process(all) 
  begin
    count_next <= count_reg + 1; 
  end process COUNTING; 

  process(all) 
  begin
    if reset then 
      count_reg <= (others => '0');
    elsif rising_edge(mclk) then 
      count_reg <= count_next;
    end if; 
  end process;

  SET_PULSE: 
  process(mclk)
  begin 
    if rising_edge(mclk) then 
      if abs(signed(duty_cycle)) > abs(signed('0' & count_reg(15 downto 9))) then 
        PWM <= '1'; 
      else 
        PWM <= '0';
      end if; 
    end if;
  end process SET_PULSE;

  current_state <= reverse_idle when reset else next_state when rising_edge(mclk);

  NEXT_STATE_CL: 
  process(all)  
  begin 
    case current_state is 
      when reverse_idle => 
          next_state <= reverse when signed(duty_cycle) < 0 else forward_idle;
      when reverse => 
          next_state <= reverse when signed(duty_cycle) < 0 else reverse_idle;
      when forward_idle => 
          next_state <= forward when signed(duty_cycle) > 0 else reverse_idle;
      when forward => 
          next_state <= forward when signed(duty_cycle) > 0 else forward_idle;
      end case;
    end process NEXT_STATE_CL;

  OUTPUT_CL:
  process(all) 
  begin
      case current_state is 
        when reverse_idle => 
          en <= '0';
          dir <= '0';
        when reverse => 
          en <= PWM;
          dir <= '0';
        when forward_idle => 
          en <= '0';
          dir <= '1'; 
        when forward => 
          en <= PWM;
          dir <= '1';
        end case;
  end process OUTPUT_CL; 
end architecture;
