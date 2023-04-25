library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 

entity quadrature_decoder is 
  port(
    clk        : in std_logic; 
    reset       : in std_logic; 
    synch_a     : in std_logic; 
    synch_b     : in std_logic; 
    pos_inc     : out std_logic; 
    pos_dec     : out std_logic
  );
end entity quadrature_decoder; 

architecture rtl of quadrature_decoder is 
  type state_type is (S_reset, S_init, S_0, S_1, S_2, S_3); 
  signal current_state, next_state : state_type; 
  signal AB : std_logic_vector(1 downto 0); 
  signal err : std_logic; 

begin 

  current_state <= S_reset when reset else next_state when rising_edge(clk); 

  AB <= synch_a & synch_b; 

  NEXT_STATE_CL: process(all) is 
  begin 
    case current_state is 
      when S_reset => 
        next_state <= S_init; 
      
      when S_init => 
        next_state <= 
                     S_0 when AB = "00" else 
                     S_1 when AB = "01" else 
                     S_2 when AB = "11" else 
                     S_3; 
      
      when S_0 => 
        next_state <= 
                     S_0 when AB = "00" else 
                     S_1 when AB = "01" else 
                     S_reset when AB = "11" else 
                     S_3; 

      when S_1 => 
        next_state <= 
                     S_0 when AB = "00" else 
                     S_1 when AB = "01" else 
                     S_2 when AB = "11" else 
                     S_reset;
      
      when S_2 => 
        next_state <= 
                     S_reset when AB = "00" else 
                     S_1 when AB = "01" else 
                     S_2 when AB = "11" else 
                     S_3; 

      when S_3 =>  
        next_state <= 
                     S_0 when AB = "00" else 
                     S_reset when AB = "01" else 
                     S_2 when AB = "11" else 
                     S_3; 
      end case; 
    end process NEXT_STATE_CL;

    OUTPUT_CL: process(all) is 
    begin 
      pos_inc <= '0';
      pos_dec <= '0';
      err <= '0';
      case current_state is 
        when S_reset => 
          pos_inc <= '0';
          pos_dec <= '0';
          err <= '0';

        when S_init => 
          pos_inc <= '0';
          pos_dec <= '0';
          err <= '0';

        when S_0 => 
          pos_inc <= '1' when AB = "01" else '0';
          pos_dec <= '1' when AB = "10" else '0';
          err <= '1' when AB = "11" else '0';
       
        when S_1 => 
          pos_inc <= '1' when AB = "11" else '0';
          pos_dec <= '1' when AB = "00" else '0';
          err <= '1' when AB = "10" else '0';
    
        when S_2 => 
          pos_inc <= '1' when AB = "10" else '0';
          pos_dec <= '1' when AB = "01" else '0';
          err <= '1' when AB = "00" else '0';

        when S_3 => 
          pos_inc <= '1' when AB = "00" else '0';
          pos_dec <= '1' when AB = "11" else '0';
          err <= '1' when AB = "01" else '0';

        end case; 
      end process OUTPUT_CL;

end architecture rtl;
