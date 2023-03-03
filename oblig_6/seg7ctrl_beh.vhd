library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
library work; 
use work.conv_bin_sig.all;


architecture beh of seg7ctrl is 
   
  component counter is 
    port( 
        clk     : in std_logic; 
        reset   : in std_logic; 
        up      : in std_logic; 
        count   : out std_logic_vector(19 downto 0); 
  ); 

  -- Counter specific signals 
  signal c_up        : std_logic := '0';   
  signal c_count     : std_logic_vector(19 downto 0) := (others => '0'); 

  -- seg7ctrl specific signals
  signal seg7_out    : std_logic_vector(6 downto 0); 
  signal d_select    : std_logic := 0; 

begin 
  -- Instatiating the counter
  seg7_counter: counter port map(
    clk => m_clk, 
    reset => reset, 
    up => c_up, 
    count => c_count
  );

  process(m_clk, reset)
  begin 
    if reset = '1': 
      c_up <= '0'; 
      d_select <= '0'; 
      seg7_out <= '0';
      c <= '0'; 
    elsif rising_egde(m_clk) then 
      c_up <= '1'; 
      if c_count = 999999 then 
        d_select = not d_select; 
        c_up <= '0';
      end if; 
    end if; 
  end process; 

  process(d_select, d0, d1)
  begin
    if d_select = '0' then 
      seg7_out <= bin2ssd(d0);
    else
      seg7_out <= bin2ssd(d1); 
    end if; 
  end process;

  abcdefg <= seg7_out; 
  c <= d_select;
end architecture beh;      

  
          
