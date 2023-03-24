library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_logic_unsigned.all;
use ieee.numeric_std.all;

entity mcpv is
    Port ( MISO : in STD_LOGIC;
           MOSI : out STD_LOGIC;
           CS : out STD_LOGIC;
           SCLK : out STD_LOGIC;
           CLK : in STD_LOGIC;
           ou :out std_logic_vector(7 downto 0)
           );
end mcpv;

architecture Behavioral of mcpv is
constant N : integer := 4;
signal prescaler_counter : integer range 0 to 50000000 := 0;
signal newClock : std_logic := '0';
signal TX :std_logic_vector(N downto 0) := "11000";
signal RX : std_logic_vector(9 downto 0) := "0000000000";
type state_type is (start,state2,state3,state4,state5);  --type of state machine.
signal state : state_type := start;
signal shift_counter: integer range 0 to 750:= N;
begin

prescaler01: process(clk, newClock)
begin
    if rising_edge(clk) then 
        if prescaler_counter < 1000000 then 
            prescaler_counter <= prescaler_counter + 1;
        else
            newClock <= not newClock;
            prescaler_counter <= 0;
       end if;
    end if;            
end process;

SCLK <= newClock;


SPI_state: process(newClock)
begin
   if falling_edge(newClock) then      
        case state is   
            when start =>
                CS <= '1';
                MOSI <= '0';
                --busy <= '1';
                RX <= "0000000000";
            state <= state2;
            when state2 => -- Send init bits. 
                CS <= '0';
                shift_counter <= shift_counter - 1;
                TX <= TX(N-1 downto 0) & TX(N); 
                MOSI <= TX(N);
                if shift_counter = 0 then 
                   MOSI <= '0';
                   shift_counter<= 12;
                   state <= state3;
                end if;
            when state3 =>
                --MOSI <= '0';
                CS <= '0';              -- Last bit init bit;
                state <= state5; 
            when state4=>
                CS <= '0';              --T_sample from falling - falling
                state <= state5;     
            when state5=>
               CS <= '0';              -- Read
               if shift_counter = 0 then
                  MOSI <= '0';
                  shift_counter<= N;
                  --busy <= '0';
                  state <= start;
              elsif shift_counter < 11 then 
                RX <=  RX(8 downto 0) & MISO;
                shift_counter <= shift_counter - 1;
              else
                 shift_counter <= shift_counter - 1;
              end if;
              ou <= RX(7 downto 0);
            when others =>    
                state <= start;           
        end case;
    end if;  
end process;
               end Behavioral;