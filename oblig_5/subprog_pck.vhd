library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 


package subprog_pck is

  function xor_par(indata2: unsigned) return std_logic;

  function toggle_par(indata1: std_logic_vector) return std_logic;
  
  procedure test_pargen(signal clk : in std_logic; signal my_data : out unsigned); 


end package subprog_pck;

package body subprog_pck is    
  
  function toggle_par(indata1: std_logic_vector) return std_logic is 
      variable toggle : std_logic := '0';
   begin
      for i in indata1'range loop 
        if indata1(i) = '1' then 
              toggle := not toggle; 
          end if; 
      end loop; 
      return std_logic(toggle);
    end;

  function xor_par(indata2: unsigned) return std_logic is 
      variable xor_pa : std_logic := '0';
  begin
      xor_pa := xor(indata2);
      return std_logic(xor_pa); 
  end; 
 
  procedure test_pargen(signal clk : in std_logic; signal my_data : out unsigned) is  
  
  begin
    for i in 0 to 255 loop
        my_data <= to_unsigned(i, my_data'length);
        wait until rising_edge(clk); 
      end loop; 
  end; 

end package body subprog_pck;
