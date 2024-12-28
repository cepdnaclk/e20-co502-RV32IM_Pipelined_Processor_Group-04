library ieee;
use ieee.std_logic_1164.all;



entity SignExtender64Bit is
    port(
        input_1 : IN std_logic ;
        output_1 : OUT std_logic_vector(63 downto 0)
    );
end entity SignExtender64Bit;


architecture Logic_1 of SignExtender64Bit is
    begin
        process(input_1)
        begin
            output_1 <= (others => input_1);
        end process;
end architecture Logic_1;
