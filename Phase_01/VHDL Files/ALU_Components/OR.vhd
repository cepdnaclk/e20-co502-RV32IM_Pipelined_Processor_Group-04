LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


entity orer is 
    port(input_1 , input_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
         output_1 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
end entity orer;


architecture logic_2 OF orer is
   begin
    process(input_1, input_2)
        begin
            output_1 <= input_1 OR input_2;
    end process; 

end architecture logic_2;