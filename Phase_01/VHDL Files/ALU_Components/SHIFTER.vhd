library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Shifter is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        Sel : IN std_logic_vector(2 downto 0);
        output_1 : OUT std_logic_vector(31 downto 0)
    );
end entity Shifter;


architecture logic_1 of Shifter is

    component ShiftLeftLogical is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component ShiftRightLogical is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    begin
        

        process()
        begin
        
            end process;

end architecture logic_1;