library ieee;
use ieee.std_logic_1164.all;

entity mux4to1_64Bit is
    port(
        input_1 : IN std_logic_vector(63 downto 0);
        input_2 : IN std_logic_vector(63 downto 0);
        input_3 : IN std_logic_vector(63 downto 0);
        input_4 : IN std_logic_vector(63 downto 0);
        sel : IN std_logic_vector(1 downto 0);
        output_1 : OUT std_logic_vector(63 downto 0)
    );
end entity mux4to1_64Bit;


architecture Logic_1 of mux4to1_64Bit is
    begin
        process(input_1, input_2, input_3, input_4, sel)
        begin
            case sel is
                when "00" =>
                    output_1 <= input_1;
                when "01" =>
                    output_1 <= input_2;
                when "10" =>
                    output_1 <= input_3;
                when "11" =>
                    output_1 <= input_4;
                when others =>
                    output_1 <= (others => 'X');
            end case;
        end process;
end architecture Logic_1;