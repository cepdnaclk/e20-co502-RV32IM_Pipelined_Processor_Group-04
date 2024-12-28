library ieee;
use ieee.std_logic_1164.all;



entity SignExtender32Bit is
    port(
        input_1 : IN std_logic ;
        output_1 : OUT std_logic_vector(31 downto 0)
    );
end entity SignExtender32Bit;


architecture Logic_1 of SignExtender32Bit is
    begin
        process(input_1)
        begin
            output_1 <= (others => input_1);
        end process;
end architecture Logic_1;
