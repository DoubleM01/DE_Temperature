library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity DEtemp is
    port(
        clk: in std_logic;
        outputled: out  std_logic;
        mcpoutput: out std_logic_vector(9 downto 0);
        bcdoutput: out std_logic_vector(11 downto 0);
        --MISO : in STD_LOGIC;
         rledo: out std_logic;
         gledo: out std_logic
    );
    end toplevel;
    architecture arch of DEtemp is
component mcpv 
        Port ( MISO : in STD_LOGIC;
               MOSI : out STD_LOGIC;
               CS : out STD_LOGIC;
               SCLK : out STD_LOGIC;
               CLK : in STD_LOGIC;
               ou :out std_logic_vector(9 downto 0)
               );
    end component;
    component lcdv
    port (
        bin:    in  std_logic_vector (9 downto 0);
        bcd:    out std_logic_vector (11 downto 0)
    );
end component;
component ledv
port (
    clock: in std_logic;
    ledselect: in std_logic;
    rled: out std_logic;
    gled: out std_logic
  ) ;
  end component ;
  signal doutmcp:  std_logic_vector(7 downto 0);

  signal MISO :  STD_LOGIC;
  signal MOSI :  STD_LOGIC;
  signal CS :  STD_LOGIC;
  signal SCLK : STD_LOGIC;
  --signal clock:  std_logic;
  signal ledselect: std_logic;
  signal rled:  std_logic;
  --signal gled:  std_logic;
  --signal bin:    std_logic_vector (9 downto 0);
  signal bcd:   std_logic_vector (11 downto 0);
signal ot:std_logic_vector(9 downto 0);           
  --signal 
        begin
            
                mcpv_ins : mcpv 
                port map (
                    MISO => MISO,
                    MOSI => MOSI,
                    cs => cs,
                    SCLK => SCLK,
                    clk => CLK,
                    ou=>ot
                );
                mcpoutput <=ot;
                lcdv_ins: lcdv port map(
                    bin => ot,
                    bcd =>bcd
                );
                process(clk)
            

            begin
                if(ot > "0000100101") then 
                ledselect <= '1';
                else 
                ledselect <= '0';
                end if;
            end process;
                ledv_ins: ledv port map(
                 clock =>CLK,
                 ledselect =>  ledselect,
                 rled => rledo,
                 gled => gledo
                );
                --end process;
            end arch;