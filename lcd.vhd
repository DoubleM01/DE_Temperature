LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY lcd IS
  PORT(
      clk       : IN  STD_LOGIC;  --system clock
      mode		: IN  STD_LOGIC_VECTOR(1 DOWNTO 0); -- Select Between Voltmeter,Ammeter,Ohometa and Beta
      reset		: IN  STD_LOGIC;  --Active Low
      rw, rs, e : OUT STD_LOGIC;  --read/write, setup/data, and enable for lcd
      lcd_data  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --data signals for lcd
END lcd;

ARCHITECTURE behavior OF lcd IS
  SIGNAL   lcd_enable : STD_LOGIC;
  SIGNAL   lcd_bus    : STD_LOGIC_VECTOR(9 DOWNTO 0);
  SIGNAL   lcd_busy   : STD_LOGIC;
  COMPONENT lcd_controller IS
    PORT(
       clk        : IN  STD_LOGIC; --system clock
       reset_n    : IN  STD_LOGIC; --active low reinitializes lcd
       lcd_enable : IN  STD_LOGIC; --latches data into lcd controller
       lcd_bus    : IN  STD_LOGIC_VECTOR(9 DOWNTO 0); --data and control signals
       busy       : OUT STD_LOGIC; --lcd controller busy/idle feedback
       rw, rs, e  : OUT STD_LOGIC; --read/write, setup/data, and enable for lcd
       lcd_data   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --data signals for lcd
  END COMPONENT;
BEGIN

  --instantiate the lcd controller
  dut: lcd_controller
    PORT MAP(clk => clk, reset_n => reset, lcd_enable => lcd_enable, lcd_bus => lcd_bus, 
             busy => lcd_busy, rw => rw, rs => rs, e => e, lcd_data => lcd_data);
  
  PROCESS(clk)
    VARIABLE char  :  INTEGER RANGE 0 TO 10 := 0;
  BEGIN


    if(clk'EVENT AND clk = '1') THEN
      IF(lcd_busy = '0' AND lcd_enable = '0') THEN
        lcd_enable <= '1';


			IF(mode="00")THEN --Voltmeter
                IF(char < 10) THEN
				char := char + 1;
				END IF;
				CASE char IS
					WHEN 1 => lcd_bus <= "1001010110"; --V
					WHEN 2 => lcd_bus <= "1001101111"; --o
					WHEN 3 => lcd_bus <= "1001101100"; --l
					WHEN 4 => lcd_bus <= "1001110100"; --t
					WHEN 5 => lcd_bus <= "1001101101"; --m
					WHEN 6 => lcd_bus <= "1001100101"; --e
					WHEN 7 => lcd_bus <= "1001110100"; --t
					WHEN 8 => lcd_bus <= "1001100101"; --e
					WHEN 9 => lcd_bus <= "1001110010"; --r
					WHEN OTHERS => lcd_enable <= '0';
				END CASE;
        
			ELSIF(mode="01") THEN --Ammeter
                IF(char < 10) THEN
				char := char + 1;
				END IF;
				CASE char IS
					WHEN 1 => lcd_bus <= "1001000001"; --A
					WHEN 2 => lcd_bus <= "1001101101"; --m
					WHEN 3 => lcd_bus <= "1001101101"; --m
					WHEN 4 => lcd_bus <= "1001100101"; --e
					WHEN 5 => lcd_bus <= "1001110100"; --t
					WHEN 6 => lcd_bus <= "1001100101"; --e
					WHEN 7 => lcd_bus <= "1001110010"; --r
					WHEN OTHERS => lcd_enable <= '0';
				END CASE;
        
			ELSIF(mode="10") THEN --Ohmmeter
				IF(char < 10) THEN
				char := char + 1;
				END IF;
				CASE char IS
					WHEN 1 => lcd_bus <= "1001001111"; --O
					WHEN 2 => lcd_bus <= "1001101000"; --h
					WHEN 3 => lcd_bus <= "1001101101"; --m
					WHEN 4 => lcd_bus <= "1001101101"; --m
					WHEN 5 => lcd_bus <= "1001100101"; --e
					WHEN 6 => lcd_bus <= "1001110100"; --t
					WHEN 7 => lcd_bus <= "1001100101"; --e
					WHEN 8 => lcd_bus <= "1001110010"; --r
					WHEN OTHERS => lcd_enable <= '0';
				END CASE;
		
			ELSIF(mode="11") THEN --Beta"meter
			    IF(char < 10) THEN
				char := char + 1;
				END IF;
				CASE char IS
					WHEN 1 => lcd_bus <= "1001000001"; --B
					WHEN 2 => lcd_bus <= "1001100101"; --e
					WHEN 3 => lcd_bus <= "1001110100"; --t
					WHEN 4 => lcd_bus <= "1001100001"; --a
					WHEN 5 => lcd_bus <= "1001101101"; --m
					WHEN 6 => lcd_bus <= "1001100101"; --e
					WHEN 7 => lcd_bus <= "1001110100"; --t
					WHEN 8 => lcd_bus <= "1001100101"; --e
					WHEN 9 => lcd_bus <= "1001110010"; --r
					WHEN OTHERS => lcd_enable <= '0';
				END CASE;
			END IF;
      ELSE
        lcd_enable <= '0';
      END IF;
    END IF;
  END PROCESS;
  
END behavior;

------------------------------------------
--------------------------------------------------------------------------------
--
--   FileName:         lcd_controller.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 32-bit Version 11.1 Build 173 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 6/2/2006 Scott Larson
--     Initial Public Release
--    Version 2.0 6/13/2012 Scott Larson
--
--   CLOCK FREQUENCY: to change system clock frequency, change Line 65gfdg
--
--   LCD INITIALIZATION SETTINGS: to change, comment/uncomment lines:
--
--   Function Set  
--      2-line mode, display on             Line 93    lcd_data <= "00111100";
--      1-line mode, display on             Line 94    lcd_data <= "00110100";
--      1-line mode, display off            Line 95    lcd_data <= "00110000";
--      2-line mode, display off            Line 96    lcd_data <= "00111000";
--   Display ON/OFF
--      display on, cursor off, blink off   Line 104   lcd_data <= "00001100";
--      display on, cursor off, blink on    Line 105   lcd_data <= "00001101";
--      display on, cursor on, blink off    Line 106   lcd_data <= "00001110";
--      display on, cursor on, blink on     Line 107   lcd_data <= "00001111";
--      display off, cursor off, blink off  Line 108   lcd_data <= "00001000";
--      display off, cursor off, blink on   Line 109   lcd_data <= "00001001";
--      display off, cursor on, blink off   Line 110   lcd_data <= "00001010";
--      display off, cursor on, blink on    Line 111   lcd_data <= "00001011";
--   Entry Mode Set
--      increment mode, entire shift off    Line 127   lcd_data <= "00000110";
--      increment mode, entire shift on     Line 128   lcd_data <= "00000111";
--      decrement mode, entire shift off    Line 129   lcd_data <= "00000100";
--      decrement mode, entire shift on     Line 130   lcd_data <= "00000101";
--    
--------------------------------------------------------------------------------

