library ieee;
use ieee.std_logic_1164.all;


entity ZeroExtenderAndShifter is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        output_1 : OUT std_logic_vector(63 downto 0)
    );
end entity ZeroExtenderAndShifter;  


architecture Logic_1 of ZeroExtenderAndShifter is
    begin
        process(input_1)
        begin
            case input_2 is
                when "00000000000000000000000000000000" =>
                    output_1 <= "00000000000000000000000000000000" & input_1;
                when "00000000000000000000000000000001" =>
                    output_1 <= "0000000000000000000000000000000" & input_1 & "0";
                when "00000000000000000000000000000010" =>
                    output_1 <= "000000000000000000000000000000" & input_1 & "00";
                when "00000000000000000000000000000011" =>
                    output_1 <= "00000000000000000000000000000" & input_1 & "000";
                when "00000000000000000000000000000100" =>
                    output_1 <= "0000000000000000000000000000" & input_1 & "0000";
                when "00000000000000000000000000000101" =>
                    output_1 <= "000000000000000000000000000" & input_1 & "00000";
                when "00000000000000000000000000000110" =>
                    output_1 <= "00000000000000000000000000" & input_1 & "000000";
                when "00000000000000000000000000000111" =>
                    output_1 <= "0000000000000000000000000" & input_1 & "0000000";
                when "00000000000000000000000000001000" =>
                    output_1 <= "000000000000000000000000" & input_1 & "00000000";
                when "00000000000000000000000000001001" =>
                    output_1 <= "00000000000000000000000" & input_1 & "000000000";
                when "00000000000000000000000000001010" =>
                    output_1 <= "0000000000000000000000" & input_1 & "0000000000";
                when "00000000000000000000000000001011" =>
                    output_1 <= "000000000000000000000" & input_1 & "00000000000";
                when "00000000000000000000000000001100" =>
                    output_1 <= "00000000000000000000" & input_1 & "000000000000";
                when "00000000000000000000000000001101" =>
                    output_1 <= "0000000000000000000" & input_1 & "0000000000000";
                when "00000000000000000000000000001110" =>
                    output_1 <= "000000000000000000" & input_1 & "00000000000000";
                when "00000000000000000000000000001111" =>
                    output_1 <= "00000000000000000" & input_1 & "000000000000000";
                when "00000000000000000000000000010000" =>
                    output_1 <= "0000000000000000" & input_1 & "0000000000000000";
                when "00000000000000000000000000010001" =>
                    output_1 <= "000000000000000" & input_1 & "00000000000000000";
                when "00000000000000000000000000010010" =>
                    output_1 <= "00000000000000" & input_1 & "000000000000000000";
                when "00000000000000000000000000010011" =>
                    output_1 <= "0000000000000" & input_1 & "0000000000000000000";
                when "00000000000000000000000000010100" =>
                    output_1 <= "000000000000" & input_1 & "00000000000000000000";
                when "00000000000000000000000000010101" =>
                    output_1 <= "00000000000" & input_1 & "000000000000000000000";
                when "00000000000000000000000000010110" =>
                    output_1 <= "0000000000" & input_1 & "0000000000000000000000";
                when "00000000000000000000000000010111" =>
                    output_1 <= "000000000" & input_1 & "00000000000000000000000";
                when "00000000000000000000000000011000" =>
                    output_1 <= "00000000" & input_1 & "000000000000000000000000";
                when "00000000000000000000000000011001" =>
                    output_1 <= "0000000" & input_1 & "0000000000000000000000000";
                when "00000000000000000000000000011010" =>
                    output_1 <= "000000" & input_1 & "00000000000000000000000000";
                when "00000000000000000000000000011011" =>
                    output_1 <= "00000" & input_1 & "000000000000000000000000000";
                when "00000000000000000000000000011100" =>
                    output_1 <= "0000" & input_1 & "0000000000000000000000000000";
                when "00000000000000000000000000011101" =>
                    output_1 <= "000" & input_1 & "00000000000000000000000000000";
                when "00000000000000000000000000011110" =>
                    output_1 <= "00" & input_1 & "000000000000000000000000000000";
                when "00000000000000000000000000011111" =>
                    output_1 <= "0" & input_1 & "0000000000000000000000000000000";
                when "00000000000000000000000000100000" =>
                    output_1 <= input_1 & "00000000000000000000000000000000";

                when others =>
                    output_1 <= (others => 'Z');

            end case;
        end process;
end architecture Logic_1;

