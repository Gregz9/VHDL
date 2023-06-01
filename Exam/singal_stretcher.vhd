library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_STD.all; 

entity signal_stretcher is 
  generic(N : integer := 2);
  port( clk  : in std_logic; 
        reset: in std_logic; 
        x    : in std_logic; 
        z    : out std_logic));
end entity signal_stretcher; 

architecture rtl of signal_stretcher is 

  signal counter, next_counter : integer;
  type state_type is (S_idle, S_start, S_stretch); 
  signal current_state, next_state :state_type; 

begin

  -- Sequential statement assignment 
  current_state <= S_idle when reset else next_state when rising_edge(clk);
  count <= 2 when reset else next_count; 

  -- Next state logic
  NEXT_STATE_CL: process(all) is 
  begin 
    case current_state is
      when S_idle => 
        next_state <= 
            S_start when x else 
            S_idle;
      when S_start => 
        next_state <= 
            S_start when x else 
            S_stretch;
      when S_stretch => 
        next_state <= S_start when x else 
                      S_idle when (not x and counter > 0) else 
                      S_stretch; 
      when other => 
        next_state <= S_idle;
    end case; 
  end process NEXT_STATE_CL;


  -- Output logic 
  OUTPUT_CL : process(all) is 
    z <= '0'; 
    next_count <= '0';
    case current_state is 
      when S_idle => 
        null;
      when S_start =>
        z <= '1'; 
      when stretch => 
        z <= '1'; 
        next_count <= counter + 1 ;
      when others => null; 
    end case; 
  end process; 
end architecture; 


