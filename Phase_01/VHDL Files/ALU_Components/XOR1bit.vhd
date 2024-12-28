library ieee;
use ieee.std_logic_1164.all;

entity xor1Bit is
    port(
        input_1 : IN std_logic;
        input_2 : IN std_logic;
        output_1 : OUT std_logic
    );
end entity xor1Bit;


architecture Logic_1 of xor1Bit is
    begin
        process(input_1, input_2)
        begin
            if(input_1 = '1' and input_2 = '1') then
                output_1 <= '0';

            elsif(input_1 = '0' and input_2 = '0') then
                output_1 <= '0';

            elsif(input_1 = '1' and input_2 = '0') then
                output_1 <= '1';

            elsif(input_1 = '0' and input_2 = '1') then
                output_1 <= '1';

            else
                output_1 <= 'Z';
            end if;
        end process;
end architecture Logic_1;