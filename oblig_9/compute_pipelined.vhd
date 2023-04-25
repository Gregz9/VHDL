library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compute_pipelined is
  port(
    rst : in std_logic;
    clk : in std_logic;
    a : in std_logic_vector(15 downto 0);
    b : in std_logic_vector(15 downto 0);
    c : in std_logic_vector(15 downto 0);
    d : in std_logic_vector(15 downto 0);
    e : in std_logic_vector(15 downto 0);
    dvalid : in std_logic;
    result : out std_logic_vector(31 downto 0);
    max : out std_logic;
    rvalid : out std_logic);
end entity compute_pipelined;

architecture RTL of compute_pipelined is
    signal next_result : unsigned(31 downto 0);
    signal next_max : std_logic;
    signal sum_reg  : unsigned(17 downto 0); 
    signal dvalid_reg : std_logic := '0';
    signal i_sum : unsigned(17 downto 0);
    signal i_product : unsigned(33 downto 0);
    signal i_overflow : std_logic;
    signal e_reg      : std_logic_vector(15 downto 0);

  begin
    REG_ASSIGNMENT: process(clk) is
    begin
      if rising_edge(clk) then
        if rst then
          result <= (others => '0');
          max <= '0';
          dvalid_reg <= '0';
          rvalid <= '0';
          sum_reg <= (others => '0');
          e_reg <= (others => '0');
        else
          result <= std_logic_vector(next_result);
          dvalid_reg <= dvalid;
          rvalid <= dvalid_reg;
          max <= next_max;
          sum_reg <= i_sum;
          e_reg <= e;

        end if;
      end if;
    end process;

  ADDITION: process (all) is
    begin
    i_sum <= (unsigned("00" & a) + unsigned("00" & b)) +
             (unsigned("00" & c) + unsigned("00" & d));

    i_product <= sum_reg * unsigned(e_reg);
    i_overflow <= or i_product(33 downto 32);
    if dvalid_reg then
      next_max <= i_overflow;
      next_result <= (others => '1') when i_overflow else i_product(31 downto 0);
    else
      next_max <= '0';
      next_result <= (others => '0');
    end if;
  end process;
end architecture RTL;
