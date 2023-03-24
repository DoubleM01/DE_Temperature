
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin8bcd_tb is
    end entity;
    
    architecture foo of bin8bcd_tb is
        signal bin: std_logic_vector (7 downto 0) := (others => '0');
        -- (initialized to prevent those annoying metavalue reports)
    
        signal bcd: std_logic_vector (11 downto 0);
    
    begin
    
    DUT:
        entity work.lcdv
            port map (
                bin => bin,
                bcd => bcd
            );
    
    STIMULUS:
        process
    
        begin
            for i in 0 to 255 loop
                bin <= std_logic_vector(to_unsigned(i,8));
                wait for 1 ns;
            end loop;
            wait for 1 ns;
            wait;
        end process;
    end architecture;