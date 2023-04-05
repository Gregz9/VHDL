library IEEE; 
use IEEE.std_logic_1164.all; 

entity quadrature_decoder is 
  port 
    ( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      synch_a   : in std_logic; 
      synch_b   : in std_logic; 
      pos_inc   : out std_logic; 
      pos_dec   : out std_logic 
    ); 
end entity quadrature_decoder; 

architecture rtl of quadrature_deccoder is 
  type state_type is (S_reset, S_init, S_0, S_1, S_2, S_3);
  signal current_state, next_state : state_type;
  signal err, inc, dec : std_logic; 

begin 
  
  STATE_TRANSISTION: process(clk, reset) 
  begin 
    if reset or err then 
      current_state <= S_reset; 
    elsif rising_edge(clk) then
      current_state <= next_state; 
    end if; 
  end process; 

  SIGNAL_ASSIGNMENT: process(clk, reset) 
    if rising_edge(clk) then 
      pos_inc <= inc; 
      pos_dec <= dec; 
    end if; 
  end process SIGNAL_ASSIGNMENT;


  NEXT_STATE_CL: process(all) 
  begin 
    case current_state is 
      when S_reset => 
        next_state <= S_init;
      when S_init => 
        case synch_a & synch_b is 
          when "00" => 
            next_state <= S_0; 
          when "01" => 
            next_state <= S_1; 
          when "11" => 
            next_state <= S_2; 
          when "10" => 
            next_state <= S_3;
        end case; 
      when S_0 => 
        case synch_a & synch_b is 
          when "00" => 
            next_state <= S_0; 
          when "01" => 
            next_state <= S_1; -- inc
          when "11" => 
            next_state <= S_reset; -- err
          when "10" => 
            next_state <= S_3; -- dec
          end case; 
        when S_1 => 
          case synch_a & synch_b is 
            when "00" => 
              next_state <= S_0; -- dec 
            when "01" => 
              next_state <= S_1; 
            when "11" => 
              next_state <= S_2; -- inc
            when "10" => 
              next_state <= S_reset; -- err
          end case; 
        when S_2 =>
          case synch_a & synch_b is 
            when "00" => 
              next_state <= S_reset; -- err 
            when "01" => 
              next_state <= S_1; -- dec  
            when "11" => 
              next_state <= S_2; 
            when "10" => 
              next_state <= S_3; -- inc
          end case; 
        when S_3 => 
          case synch_a & synch_b is 
            when "00" => 
              next_state <= S_0; -- inc
            when "01" => 
              next_state <= S_reset; -- err
            when "11" => 
              next_state <= S_2;  -- dec  
            when "10" => 
              next_state <= S_3;
          end case; 
      end case; 
    end process NEXT_STATE_CL;

    OUTPUT_LOGIC: process(all) 
    begin 
      case current_state is 
        when S_reset => 
          inc <= '0';
          dec <= '0';
        when S_init => 
          inc <= '0'; 
          dec <= '0'; 
        when S_1 => 
          inc <= '1' when synch_a and synch_b else '0';
          dec <= '1' when not synch_a and not synch_b else '0';
          err <= '1' when 




