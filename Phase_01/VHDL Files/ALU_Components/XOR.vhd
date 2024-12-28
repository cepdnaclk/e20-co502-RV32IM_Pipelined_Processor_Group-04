library ieee;
use ieee.std_logic_1164.all;


entity xorer is
    port(
        input_1 : IN std_logic_vector (31 downto 0);
        input_2 : IN std_logic_vector (31 downto 0);
        output_1 : OUT std_logic_vector (31 downto 0)
    );
end entity xorer;


architecture Logic_1 of xorer is
    begin
        process(input_1, input_2)
            begin
            
                output_1 <= input_1 xor input_2;

        end process;

    end architecture Logic_1;