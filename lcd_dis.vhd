library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity lcd_dis is
    port(
        lcd_busy : in std_logic;
        clk : in std_logic;
        lcd_clk : out std_logic;
        reset_n : out std_logic;
        lcd_enable : buffer std_logic;
        lcd_bus : out std_logic_vector(9 downto 0)
    );
    end lcd_dis;
    architecture behavior of lcd_dis IS
    begin
        process(clk)
            variable char: integer range 0 to 12:= 0;
        begin
            if clk'Event and clk ='1' then
                if lcd_busy ='0' and lcd_enable ='0'  then
                    lcd_enable <= '1';
                    if (char < 12) then
                        char := char + 1;
                        end if;
                        case char is
                            WHEN 1 => lcd_bus <= "1100110001";
                            WHEN 2 => lcd_bus <= "1100110010";
                            WHEN 3 => lcd_bus <= "1100110011";
                            WHEN 4 => lcd_bus <= "1100110100";
                            WHEN 5 => lcd_bus <= "1000110101";
                            WHEN 6 => lcd_bus <= "1000110110";
                            WHEN 7 => lcd_bus <= "1000110111";
                            WHEN 8 => lcd_bus <= "1000111000";
                            WHEN 9 => lcd_bus <= "1000111001";
                            WHEN 10 => lcd_bus<= "1001000001";
                            WHEN 11 => lcd_bus<= "1001000010";
                            WHEN OTHERS => lcd_enable <= '0';
                        END CASE;
                    ELSE
                        lcd_enable <= '0';
                end if ;
                
            end if ;
            end process;
            reset_n <='1';
            lcd_clk <= clk;
            end behavior;