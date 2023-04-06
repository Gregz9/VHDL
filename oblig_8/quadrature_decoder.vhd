library IEEE; 
use IEEE.std_logic_1164.all; 

entity quadrature_decoder is 
  port 
    ( 
      clk       : in std_logic; 
      reset     : in std_logic; 
      synch_a   : in std_logic; 
      synch_b   : in std_logic; 
      pos_inc   : out std_logic := '0';
      pos_dec   : out std_logic := '0'
    ); 
end entity quadrature_decoder; 

architecture rtl of quadrature_decoder is 
  type state_type is (S_reset, S_init, S_0, S_1, S_2, S_3);
  signal current_state, next_state : state_type;
  signal err, inc, dec : std_logic; 

begin 
  
  STATE_TRANSISTION: process(clk, reset) 
  begin 
    if reset or err then 
      current_state <= S_reset; 
      err <= '0';
    elsif rising_edge(clk) then
      current_state <= next_state; 
    end if; 
  end process; 

  NEXT_STATE_CL: process(all) 
  begin 
    case current_state is 
      when S_reset => 
        inc <= '0';
        dec <= '0';
        next_state <= S_init;
      when S_init => 
        inc <= '0';
        dec <= '0';
        if synch_a & synch_b = "00" then 
            next_state <= S_0; 
        elsif synch_a & synch_b = "01" then 
            next_state <= S_1; 
        elsif synch_a & synch_b = "11" then 
            next_state <= S_2; 
        elsif synch_a & synch_b = "10" then  
            next_state <= S_3;
        end if;
      when S_0 => 
        if synch_a & synch_b = "00" then 
            next_state <= S_0; 
            inc <= '0';
            dec <= '0';
        elsif synch_a & synch_b = "01" then 
            next_state <= S_1; -- inc
            inc <= '1';
        elsif synch_a & synch_b = "11" then 
            next_state <= S_reset; -- err
            err <= '1';
        elsif synch_a & synch_b = "10" then  
            next_state <= S_3; -- dec
            dec <= '1';
        end if;
      when S_1 => 
        if synch_a & synch_b = "00" then 
            next_state <= S_0; -- dec 
            dec <= '1';
        elsif synch_a & synch_b = "01" then 
            next_state <= S_1; 
            inc <= '0';
            dec <= '0';
        elsif synch_a & synch_b = "11" then 
            next_state <= S_2; -- inc
            inc <= '1';
        elsif synch_a & synch_b = "10" then  
            next_state <= S_reset; -- err
            err <= '1';
        end if;
      when S_2 =>
        if synch_a & synch_b = "00" then 
            next_state <= S_reset; -- err 
            err <= '1';
        elsif synch_a & synch_b = "01" then 
            next_state <= S_1; -- dec  
            err <= '1';
        elsif synch_a & synch_b = "11" then 
            next_state <= S_2; 
            inc <= '0';
            dec <= '0';
        elsif synch_a & synch_b = "10" then  
            next_state <= S_3; -- inc
            inc <= '1';
        end if;
      when S_3 => 
        if synch_a & synch_b = "00" then 
            next_state <= S_0; -- inc
            inc <= '1';
        elsif synch_a & synch_b = "01" then 
            next_state <= S_reset; -- err
            err <= '1';
        elsif synch_a & synch_b = "11" then 
            next_state <= S_2;  -- dec  
            dec <= '1';
        elsif synch_a & synch_b = "10" then  
            next_state <= S_3;
            inc <= '0';
            dec <= '0';
            end if;
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
        when S_0 => 
          err <= '1' when synch_a and synch_b;
          inc <= '1' when not synch_a and synch_b else '0'; 
          dec <= '1' when synch_a and not synch_b else '0';
        when S_1 => 
          err <= '1' when synch_a and not synch_b; 
          inc <= '1' when synch_a and synch_b else '0';
          dec <= '1' when not synch_a and not synch_b else '0';
        when S_2 => 
          err <= '1' when not synch_a and not synch_b; 
          inc <= '1' when synch_a and not synch_b else '0';
          dec <= '1' when not synch_a and synch_b else '0';
        when S_3 => 
          err <= '1' when not synch_a and synch_b; 
          inc <= '1' when not synch_a and not synch_b else '0';
          dec <= '1' when synch_a and synch_b else '0';
        end case;
    end process OUTPUT_LOGIC;

end architecture; 
      



