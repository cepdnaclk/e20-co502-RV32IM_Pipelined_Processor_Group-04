library ieee;
use ieee.std_logic_1164.all;

entity ander1Bit is
    port(
        input_1 : IN std_logic;
        input_2 : IN std_logic;
        output_1 : OUT std_logic
    );
end entity ander1Bit;


architecture Logic_1 of ander1Bit is
    begin
        process(input_1, input_2)
        begin
            output_1 <= input_1 and input_2;
        end process;
end architecture Logic_1;

