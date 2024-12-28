library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_32bit is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        sel : IN std_logic;
        output_1 : OUT std_logic_vector(31 downto 0)
    );
end entity mux2to1_32bit;


architecture Logic_1 of mux2to1_32bit is
    begin
        process(input_1, input_2, sel)
        begin
            if(sel = '0') then
                output_1 <= input_1;
                
            elsif   sel = '1' then
                output_1 <= input_2;

            else
                output_1 <= (others => 'Z');
            end if;
    end process;
end architecture Logic_1;