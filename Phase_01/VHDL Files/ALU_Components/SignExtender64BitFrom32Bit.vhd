library ieee;
use ieee.std_logic_1164.all;

entity SignExtender64BitFrom32Bit is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        output_1 : OUT std_logic_vector(63 downto 0)
    );
end entity SignExtender64BitFrom32Bit; 


architecture Logic_1 of SignExtender64BitFrom32Bit is
    begin
        process(input_1)
        variable extendedSign : std_logic_vector(31 downto 0 );
        begin
            extendedSign := (others => input_1(31));
            output_1 <= extendedSign &  input_1 ;
        end process;
end architecture Logic_1;