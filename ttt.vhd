ELSIF(clk_count<(120*freq))THEN
                        data<="00000000";
                        en <= '0';
                        current_s <=initialize;
                    ELSIF(clk_count<(130*freq))THEN
                        data<="00000001";
                        en <= '1';
                        current_s <=initialize;
                    ELSIF(clk_count<(300*freq))THEN
                        data<="00000000";
                        en <= '0';
                        current_s <=initialize;
                    ELSIF(clk_count<(310*freq))THEN
                        data<="00000110";
                        en <= '1';
                        current_s <=initialize;
                    ELSIF(clk_count<(340*freq))THEN
                        data<="00000000";
                        en <= '0';
                        current_s <=initialize;
                    else




                    if clk_count <(50 * freq) then
                        busy <='1';
                        if clk_count <freq then
                            en <='0';
                        elsif clk_count < (14 * freq) then
                                en <= '1';
                        elsif clk_count < (27 * freq) then
                            en <= '0';
                        end if;
                        clk_count:= clk_count + 1;
                        current_s <= send;
                    else
                        clk_count :=0;