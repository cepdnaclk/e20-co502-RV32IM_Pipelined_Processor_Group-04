library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ID_Control is
    Port (
        reset     : in  std_logic;                      -- Reset signal
        ID_Inst   : in  std_logic_vector(31 downto 0);  -- Instruction from ID stage
        ID_RegWEn : out std_logic                       -- Register File Write Enable signal
    );
end ID_Control;

architecture Behavioral of ID_Control is
begin
    process(reset, ID_Inst)
    begin
        -- Reset condition: Disable register write
        if reset = '1' then
            ID_RegWEn <= '0';
        else
            -- Default value for ID_RegWEn
            ID_RegWEn <= '0';

            case ID_Inst(6 downto 2) is
                -- R-Type Instructions
                when "01100" => 
                    ID_RegWEn <= '1';

                -- I-Type Instructions
                when "00100" => 
                    ID_RegWEn <= '1';

                -- Load Instructions
                when "00000" => 
                    ID_RegWEn <= '1';

                -- Store Instructions
                when "01000" => 
                    ID_RegWEn <= '0';

                -- Branch Instructions
                when "11000" => 
                    ID_RegWEn <= '0';

                -- JAL Instruction
                when "11011" => 
                    ID_RegWEn <= '1';

                -- JALR Instruction
                when "11001" => 
                    ID_RegWEn <= '1';

                -- LUI Instruction
                when "01101" => 
                    ID_RegWEn <= '1';

                -- AUIPC Instruction
                when "00101" => 
                    ID_RegWEn <= '1';

                -- Default case
                when others =>
                    ID_RegWEn <= '0';
            end case;
        end if;
    end process;
end Behavioral;