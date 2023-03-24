-- BCD Entity
library ieee;
use ieee.std_logic_1164.all;

entity dd is
    port (
        clk           : in  std_logic;
        rst           : in  std_logic;
        bcd_display_0 : in  std_logic_vector(3 downto 0);-- assign to first set of switches
        bcd_display_1 : in  std_logic_vector(3 downto 0);-- assign to second set of switches
        LED_0         : out std_logic_vector(6 downto 0);-- assign to first 7-segment display
        LED_1         : out std_logic_vector(6 downto 0) -- assign to second 7-segment display
    );
end dd;

architecture behav of dd is
    use ieee.numeric_std.all;
begin
    p : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then 
                LED_0 <= (others => '0');
                LED_1 <= (others => '0');
            else
                case to_integer(unsigned(bcd_display_0)) is
                    when 0 => LED_0 <= "0000001";     
                    when 1 => LED_0 <= "1001111"; 
                    when 2 => LED_0 <= "0010010"; 
                    when 3 => LED_0 <= "0000110"; 
                    when 4 => LED_0 <= "1001100"; 
                    when 5 => LED_0 <= "0100100"; 
                    when 6 => LED_0 <= "0100000"; 
                    when 7 => LED_0 <= "0001111"; 
                    when 8 => LED_0 <= "0000000";     
                    when 9 => LED_0 <= "0000100"; 
                    when others => LED_0 <= "0000000";
                end case;

                case to_integer(unsigned(bcd_display_1)) is
                    when 0 => LED_1 <= "0000001";     
                    when 1 => LED_1 <= "1001111"; 
                    when 2 => LED_1 <= "0010010"; 
                    when 3 => LED_1 <= "0000110"; 
                    when 4 => LED_1 <= "1001100"; 
                    when 5 => LED_1 <= "0100100"; 
                    when 6 => LED_1 <= "0100000"; 
                    when 7 => LED_1 <= "0001111"; 
                    when 8 => LED_1 <= "0000000";     
                    when 9 => LED_1 <= "0000100"; 
                    when others => LED_1 <= "0000000";
                end case;
            end if;
        end if;
    end process;
end behav;

--TestBench
