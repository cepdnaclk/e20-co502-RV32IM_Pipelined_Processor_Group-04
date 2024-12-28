LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


entity ander64bit is 
    port(input_1 , input_2 : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
         output_1 : OUT STD_LOGIC_VECTOR (63 DOWNTO 0));
end entity ander64bit;


architecture logic_1 OF ander64bit is
   begin
    process(input_1, input_2)
        begin
            output_1 <= input_1 AND input_2;
    end process; 

end architecture logic_1;