library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity lcdv is
 port (bin : in STD_LOGIC_VECTOR (9 downto 0);
   bcd : out STD_LOGIC_VECTOR (11 downto 0));
   
end lcdv;

architecture binbcd10_arch of lcdv is
begin
 bcd1 : process (bin)
 variable temp : STD_LOGIC_VECTOR (21 downto 0);
 
begin
 for i in 0 to 21 loop
  temp(i) := '0';
 end loop;

 temp(12 downto 3) := bin;
 
 for i in 0 to 7 loop
  if temp(9 downto 6) > 4 then
   temp(9 downto 6) := temp(9 downto 6) + 3;
  end if;
  temp(21 downto 1) := temp(20 downto 0);
 end loop;
 
 bcd <= temp(21 downto 10);
end process bcd1;
end binbcd10_arch;