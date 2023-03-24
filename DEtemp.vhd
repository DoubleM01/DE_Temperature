library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity DEtemp is
    port(
        clk: in std_logic;
        --outputled: out  std_logic;
        --mcpoutput: signal std_logic_vector(9 downto 0);
        --bcdoutput: signal std_logic_vector(11 downto 0);
        --MISO : in STD_LOGIC;
        rledo: out std_logic;
        gledo: out std_logic;
        dout : in  std_logic;
        din: out std_logic;
        cs1: out std_logic;
        dataout : out  STD_LOGIC_VECTOR (7 downto 0);
        rwf,rsf,ef : out  STD_LOGIC
    );
    end DEtemp;
    architecture arch of DEtemp is
component mcpv 
        Port ( MISO : in STD_LOGIC;
               MOSI : out STD_LOGIC;
               CS : out STD_LOGIC;
               SCLK : out STD_LOGIC;
               CLK : in STD_LOGIC;
               ou :out std_logic_vector(7 downto 0)
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
--   component ld 
--   port (
--     clk           : in  std_logic;
--     rst           : in  std_logic;
--     bcd_display_0 : in  std_logic_vector(3 downto 0);-- assign to first set of switches
--     bcd_display_1 : in  std_logic_vector(3 downto 0);-- assign to second set of switches
--     LED_0         : out std_logic_vector(6 downto 0);-- assign to first 7-segment display
--     LED_1         : out std_logic_vector(6 downto 0) -- assign to second 7-segment display
-- );
--     end component;


    component lc
    Port (clk : in  STD_LOGIC;
    --datain: in std_logic_vector(7 downto 0);
    lcd_bus: in std_logic_vector(9 downto 0);
       lcd_enable:in STD_LOGIC:='1';
       reset_n:in STD_LOGIC;
       busy : out std_logic :='0';
      
       rw,e,rs : out  STD_LOGIC;
       lcd_data : out  STD_LOGIC_VECTOR (7 downto 0)

       
       );
       end component ;

  --signal doutmcp:  std_logic_vector(7 downto 0);
--signal clk :std_logic
signal rst :std_logic;
signal bcd_display_0 :std_logic_vector(3 downto 0);
signal bcd_display_1 :std_logic_vector(3 downto 0);
signal LED_0 :std_logic_vector(6 downto 0);
signal LED_1 :std_logic_vector(6 downto 0);
  signal MISO :  STD_LOGIC;
  signal MOSI :  STD_LOGIC;
  signal CS :  STD_LOGIC;
  signal SCLK : STD_LOGIC;
  --signal clock:  std_logic;
  signal ledselect: std_logic;
  signal rled:  std_logic;
  signal reset_nf : std_logic;
  signal lcd_enable  : std_logic;
  signal lcd_bus  :  std_logic_vector(9 downto 0):="1000110101";
  signal lcd_clk : std_logic;
  signal busyf : std_logic;
  --signal gled:  std_logic;
  --signal bin:    std_logic_vector (9 downto 0);
  signal bcd:   std_logic_vector (11 downto 0);
signal ot:std_logic_vector(7 downto 0);           
  --signal 
        begin
            
                mcpv_ins : mcpv 
                port map (
                    MISO => dout,
                    MOSI => din,
                    cs => cs1,
                    SCLK => SCLK,
                    clk => CLK,
                    ou=>ot
                );
                --mcpoutput <=ot;
               
                process(clk)
            

            begin
                if(ot > "00100101") then 
                ledselect <= '1';
                else 
                ledselect <= '0';
                end if;
                dataout <= ot;
            end process;
                ledv_ins: ledv port map(
                 clock =>CLK,
                 ledselect =>  ledselect,
                 rled => rledo,
                 gled => gledo
                );
                
                lc_ins : lc port map(
                    clk,
                    
                    lcd_bus,
                       lcd_enable, 
                        reset_nf ,
                     busyf ,
                  rwf,
                     ef,
                   rsf,
                        
                     dataout
                        --lcd_bus => lcd_bus
                    );
                  -- reset_nf<= '0';
            lcd_clk <= clk;
            
            end arch;