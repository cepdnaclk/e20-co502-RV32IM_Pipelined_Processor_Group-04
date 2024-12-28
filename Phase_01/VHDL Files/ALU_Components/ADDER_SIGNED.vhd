library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity adder_signed is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        output_1 : OUT std_logic_vector(31 downto 0)
    );
end entity adder_signed;


architecture logic_1 of adder_signed is
    begin
        process(input_1, input_2)
            --variable temp : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
            variable temp : std_logic_vector(31 downto 0) := (others => 'Z');
            begin
                if (input_1(31) = '0' and input_2(31) = '0') then
                    temp := input_1 + input_2;

                    if(temp(31) = '0') then
                        output_1 <= temp;
                    else
                        output_1 <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
                    end if;

                elsif (input_1(31) = '1' and input_2(31) = '1') then
                    temp := input_1 + input_2;

                    if(temp(31) = '1') then
                        output_1 <= temp;
                    else
                        output_1 <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
                    end if;

                elsif (input_1(31) = '0' and input_2(31) = '1') then
                    output_1 <= input_1 + input_2;
                elsif (input_1(31) = '1' and input_2(31) = '0') then
                    output_1 <= input_1 + input_2;
                end if;


                --output_1 <= input_1 + input_2;
        end process;
    -- output_1 <= input_1 + input_2;

end architecture logic_1;