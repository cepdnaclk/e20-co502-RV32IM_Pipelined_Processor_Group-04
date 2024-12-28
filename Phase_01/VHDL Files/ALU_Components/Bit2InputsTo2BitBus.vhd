library ieee;
use ieee.std_logic_1164.all;


entity Bit2InputsTo2BitBus is
    port(
        input_1 : IN std_logic;
        input_2 : IN std_logic;
        output_1 : OUT std_logic_vector(1 downto 0)
    );
end entity Bit2InputsTo2BitBus;


architecture Logic_1 of Bit2InputsTo2BitBus is
    begin
        process(input_1, input_2)
        begin
            output_1 <= input_1 & input_2;
        end process;
end architecture Logic_1;