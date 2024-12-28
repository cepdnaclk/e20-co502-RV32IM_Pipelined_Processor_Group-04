library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity adder_unsigned_64_bit is
    port(
        input_1 : IN std_logic_vector(63 downto 0);
        input_2 : IN std_logic_vector(63 downto 0);
        output_1 : OUT std_logic_vector(63 downto 0)
    );
end entity adder_unsigned_64_bit;

architecture logic_1 of adder_unsigned_64_bit is
    begin
        process(input_1, input_2)
            begin
                output_1 <= input_1 + input_2;
        end process;
    
end architecture logic_1;
