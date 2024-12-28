library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SetLessThanUnsigned is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        output_1 : OUT std_logic_vector(31 downto 0)
    );
end entity SetLessThanUnsigned;


architecture Logic_1 of SetLessThanUnsigned is
    begin
        
        process(input_1,input_2)
        begin
            if(input_1 < input_2) then
                output_1 <= "00000000000000000000000000000001";
            else 
                output_1 <= "00000000000000000000000000000000";
            end if;
    end process;

end architecture Logic_1;