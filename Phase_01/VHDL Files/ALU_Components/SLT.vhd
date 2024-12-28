library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity SetLessThan is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        output_1 : OUT std_logic_vector(31 downto 0)
    );
end entity SetLessThan;


architecture Logic_1 of SetLessthan is
    begin
        process(input_1,input_2)
        begin
            if(input_1(31) = '1' and input_2(31)= '0') then
                    output_1 <= "00000000000000000000000000000001";

            elsif(input_1(31) = '0' and input_2(31)= '1') then
                    output_1 <= "00000000000000000000000000000000";

            elsif (input_1(31) = '0' and input_2(31) = '0') then
                    if(input_1 < input_2) then
                        output_1 <= "00000000000000000000000000000001";
                    else 
                        output_1 <= "00000000000000000000000000000000";
                    end if; 
            elsif (input_1(31) = '1' and input_2(31) = '1') then
                    if(input_1 < input_2) then
                        output_1 <= "00000000000000000000000000000001";
                    else
                        output_1 <= "00000000000000000000000000000000";
                    end if;
            else
                output_1 <= (others => 'Z');
            end if;
    end process;

end architecture Logic_1;