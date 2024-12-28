library ieee;
use ieee.std_logic_1164.all;

entity Noter is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        output_1 : OUT std_logic_vector(31 downto 0)
    );
end entity Noter;


architecture logic_1 of Noter is
    begin
        process(input_1)
            begin
                output_1 <= NOT input_1;
        end process;
end architecture logic_1;