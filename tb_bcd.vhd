entity tb_bcd is
    end tb_bcd;
    
    library ieee;
    use ieee.std_logic_1164.all;
    
    architecture behav of tb_bcd is
       signal clk           : std_logic := '1';
       signal rst           : std_logic := '1';
       signal bcd_display_0 : std_logic_vector(3 downto 0);
       signal bcd_display_1 : std_logic_vector(3 downto 0);
       signal LED_0         : std_logic_vector(6 downto 0);
       signal LED_1         : std_logic_vector(6 downto 0);
    begin
        clk           <= not clk after 50 ns;
        rst           <= '0' after 200 ns;
        bcd_display_0 <= "0110" after 250 ns;
        bcd_display_1 <= "0010" after 280 ns;
    
        Display_Test_inst : entity work.dd
            port map (
                clk           => clk,
                rst           => rst,
                bcd_display_0 => bcd_display_0,
                bcd_display_1 => bcd_display_1,
                LED_0         => LED_0,
                LED_1         => LED_1
            );
    end behav;