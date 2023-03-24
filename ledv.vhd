library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity ledv is
  port (
    clock: in std_logic;
    ledselect: in std_logic;
    rled: out std_logic;
    gled: out std_logic
  ) ;
end ledv;
  architecture arch of ledv is
  begin
    process(clock,ledselect)
    begin
    if (ledselect = '1') then
        rled<= '1';
        gled <='0';
    else 
    rled <= '0';
    gled <='1';
  end if;
    end process;
  end arch ; -- arch
--end ledv;