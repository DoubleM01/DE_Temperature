when  0=>           
rs <= '0';
rw <= '0';
en <= '0';
data <= "00000000";
current_s<=1;
--when current_s => s1
when  1=>           
rs <= '0';
rw <= '0';
en <= '0';
data <= "00000000";
current_s<=2;
when  2=>           
rs <= '0';
rw <= '0';
en <= '1';
data <= "00000000";
current_s<=3;
when  3 =>           
rs <= '0';
rw <= '0';
en <= '1';
data <= datain;
current_s<=4;
when others =>
current_s<=0;
--end case ;

end process;