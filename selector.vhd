library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity selector is
Port
(
clk, reset: in std_logic;
sel: out std_logic_vector(1 downto 0)
);
end selector;
architecture Behavioral of selector is
signal state, next_state: unsigned(17 downto 0);
begin
--register
process(clk, reset)
begin
if reset='1' then
state <= (others=>'0');
elsif (clk'event and clk='1') then
state <= next_state;
end if;
end process;
--next state logic
next_state <= state + 1;
--output clk/2^16 for 50MHz around 800 Hz out
sel <= std_logic_vector(state(17 downto 16));
end Behavioral;