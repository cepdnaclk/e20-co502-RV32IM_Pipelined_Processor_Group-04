library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity adder_unsigned is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        output_1 : OUT std_logic_vector(31 downto 0)
    );
end entity adder_unsigned;


architecture logic_1 of adder_unsigned is
    begin
        process(input_1, input_2)
            begin
                output_1 <= input_1 + input_2;
        end process;
    -- output_1 <= input_1 + input_2;

end architecture logic_1;
