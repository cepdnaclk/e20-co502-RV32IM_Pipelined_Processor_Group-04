library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ShiftLeftLogical is
    port(
        input_1 : IN std_logic_vector (31 downto 0);
        input_2 : IN std_logic_vector (31 downto 0);
        output_1 : OUT std_logic_vector (31 downto 0)
    );

end entity ShiftLeftLogical;


architecture Logic_1 of ShiftLeftLogical is
    begin

        process(input_1, input_2)
            begin
                case input_2 is
                    when "00000000000000000000000000000000" =>
                        output_1 <= input_1;
                    when "00000000000000000000000000000001" =>
                        output_1 <= input_1(30 downto 0) & "0";
                    when "00000000000000000000000000000010" =>
                        output_1 <= input_1(29 downto 0) & "00";
                    when "00000000000000000000000000000011" =>
                        output_1 <= input_1(28 downto 0) & "000";
                    when "00000000000000000000000000000100" =>
                        output_1 <= input_1(27 downto 0) & "0000";
                    when "00000000000000000000000000000101" =>
                        output_1 <= input_1(26 downto 0) & "00000";
                    when "00000000000000000000000000000110" =>
                        output_1 <= input_1(25 downto 0) & "000000";
                    when "00000000000000000000000000000111" =>
                        output_1 <= input_1(24 downto 0) & "0000000";
                    when "00000000000000000000000000001000" =>
                        output_1 <= input_1(23 downto 0) & "00000000";
                    when "00000000000000000000000000001001" =>
                        output_1 <= input_1(22 downto 0) & "000000000";
                    when "00000000000000000000000000001010" =>
                        output_1 <= input_1(21 downto 0) & "0000000000";
                    when "00000000000000000000000000001011" =>
                        output_1 <= input_1(20 downto 0) & "00000000000";
                    when "00000000000000000000000000001100" =>
                        output_1 <= input_1(19 downto 0) & "000000000000";
                    when "00000000000000000000000000001101" =>
                        output_1 <= input_1(18 downto 0) & "0000000000000";
                    when "00000000000000000000000000001110" =>
                        output_1 <= input_1(17 downto 0) & "00000000000000";
                    when "00000000000000000000000000001111" =>
                        output_1 <= input_1(16 downto 0) & "000000000000000";
                    when "00000000000000000000000000010000" =>
                        output_1 <= input_1(15 downto 0) & "0000000000000000";
                    when "00000000000000000000000000010001" =>
                        output_1 <= input_1(14 downto 0) & "00000000000000000";
                    when "00000000000000000000000000010010" =>
                        output_1 <= input_1(13 downto 0) & "000000000000000000";
                    when "00000000000000000000000000010011" =>
                        output_1 <= input_1(12 downto 0) & "0000000000000000000";
                    when "00000000000000000000000000010100" =>
                        output_1 <= input_1(11 downto 0) & "00000000000000000000";
                    when "00000000000000000000000000010101" =>
                        output_1 <= input_1(10 downto 0) & "000000000000000000000";
                    when "00000000000000000000000000010110" =>
                        output_1 <= input_1(9 downto 0) & "0000000000000000000000";
                    when "00000000000000000000000000010111" =>
                        output_1 <= input_1(8 downto 0) & "00000000000000000000000";
                    when "00000000000000000000000000011000" =>
                        output_1 <= input_1(7 downto 0) & "000000000000000000000000";
                    when "00000000000000000000000000011001" =>
                        output_1 <= input_1(6 downto 0) & "0000000000000000000000000";
                    when "00000000000000000000000000011010" =>
                        output_1 <= input_1(5 downto 0) & "00000000000000000000000000";
                    when "00000000000000000000000000011011" =>
                        output_1 <= input_1(4 downto 0) & "000000000000000000000000000";
                    when "00000000000000000000000000011100" =>
                        output_1 <= input_1(3 downto 0) & "0000000000000000000000000000";
                    when "00000000000000000000000000011101" =>
                        output_1 <= input_1(2 downto 0) & "00000000000000000000000000000";
                    when "00000000000000000000000000011110" =>
                        output_1 <= input_1(1 downto 0) & "000000000000000000000000000000";
                    when "00000000000000000000000000011111" =>
                        output_1 <= input_1(0) & "0000000000000000000000000000000";
                    when "00000000000000000000000000100000" =>
                        output_1 <= (others => '0');
                    when others =>
                        output_1 <= (others => 'Z');

                end case;
                --output_1 <= input_1 SLL to_integer(unsigned(input_2));
                --output_1 <= std_logic_vector(shift_left(unsigned(input_1) , unsigned(input_2)));
        end process;
end architecture Logic_1;
