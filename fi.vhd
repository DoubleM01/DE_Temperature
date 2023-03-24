state <= initialize;
 END IF;

 --cycle through initialization sequence
 WHEN initialize =>
 busy <= '1';
 clk_count := clk_count + 1;

 IF(clk_count < (10 * freq)) THEN --function set
 -- lcd_data <= "00111100"; --2-line mode, display on
 lcd_data <= "00110100"; --1-line mode, display on
 --lcd_data <= "00110000"; --1-line mdoe, display off
 --lcd_data <= "00111000"; --2-line mode, display off
 e <= '1';
 state <= initialize;
 ELSIF(clk_count < (60 * freq)) THEN --wait 50 us
 lcd_data <= "00000000";
 e <= '0';
 state <= initialize;
 ELSIF(clk_count < (70 * freq)) THEN --display on/off

 --lcd_data <= "00001100"; --display on, cursor
 lcd_data <= "00001101"; --display on, cursor off,
--lcd_data <= "00001110"; --display on, cursor on,
 --lcd_data <= "00001111"; --display on, cursor on,
 --lcd_data <= "00001000"; --display off, cursor off,
 --lcd_data <= "00001001"; --display off, cursor off,

 e <= '1';
 state <= initialize;
 ELSIF(clk_count < (120 * freq)) THEN --wait 50 us
 lcd_data <= "00000000";
 e <= '0';
 state <= initialize;
 ELSIF(clk_count < (130 * freq)) THEN --display clear
 lcd_data <= "00000001";
 e <= '1';
 state <= initialize;
 ELSIF(clk_count < (2130 * freq)) THEN --wait 2 ms
 lcd_data <= "00000000";
 e <= '0';
 state <= initialize;
 ELSIF(clk_count < (2140 * freq)) THEN --entry mode set
 lcd_data <= "00000110"; --increment mode, entire

 e <= '1';
 state <= initialize;
 ELSIF(clk_count < (2200 * freq)) THEN --wait 60 us
 lcd_data <= "00000000";
 e <= '0';
 state <= initialize;
 ELSE --initialization

 clk_count := 0;
 busy <= '0';
 state <= ready;
 END IF;

 --wait for the enable signal and then latch in the

 WHEN ready =>
 IF(lcd_enable = '1') THEN
 busy <= '1';
 rs <= '1';
 --lcd_bus(9);
 --rs<= lcd_rs;
 rw <= '1';
 --lcd_bus(8);
 --rw <= lcd_rw;
 lcd_data <= lcd_bus(7 DOWNTO 0);
 --lcd_data <= lcd_bus;
 clk_count := 0;
 state <= send;
 ELSE
 busy <= '0';
 rs <= '0';
 rw <= '0';
 lcd_data <= "00000000";
 clk_count := 0;
 state <= ready;
 END IF;

 --send instruction to lcd
 WHEN send =>
 busy <= '1';
 IF(clk_count < (50 * freq)) THEN --do not exit for 50us
 busy <= '1';
 IF(clk_count < freq) THEN --negative enable
 e <= '0';
 ELSIF(clk_count < (14 * freq)) THEN --positive enable
---half-cycle
 e <= '1';
 ELSIF(clk_count < (27 * freq)) THEN --negative enable
--half-cycle
 e <= '0';
 END IF;
 clk_count := clk_count + 1;
 state <= send;
 ELSE
 clk_count := 0;
 state <= ready;
 END IF;
