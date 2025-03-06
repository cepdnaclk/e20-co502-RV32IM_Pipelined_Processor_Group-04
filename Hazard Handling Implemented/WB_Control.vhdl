library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity WB_Control is
    Port (
        reset     : in  std_logic;                       -- Reset signal
        WB_Inst   : in  std_logic_vector(31 downto 0);   -- Instruction from WB stage
        WB_RegWEn  : out std_logic -- Register Write Enable
    );
end WB_Control;

architecture Behavioral of WB_Control is
begin
    process(reset, WB_Inst)
    begin
        -- Reset condition
        if reset = '1' then
            WB_RegWEn   <= '0';
        else
            WB_RegWEn   <= '0';
        -- Decode opcode
        case WB_Inst(6 downto 2) is
            -- R-Type Instructions
            when "01100" => 
                WB_RegWEn <= '1';
            -- I-Type Instructions
            when "00100" => 
                WB_RegWEn <= '1';
            -- Load Instructions
            when "00000" => 
                case WB_Inst(1 downto 0) is
                    when "11" =>
                        WB_RegWEn <= '1';
                    when others =>
                        WB_RegWEn <= '0';
                end case;
            -- Store Instructions
            when "01000" => 
                WB_RegWEn <= '0';
            -- Branch Instructions
            when "11000" => 
                WB_RegWEn <= '0';
            -- JAL Instruction
            when "11011" => 
                WB_RegWEn <= '1';
            -- JALR Instruction
            when "11001" => 
                WB_RegWEn <= '1';
            -- LUI Instruction
            when "01101" => 
                WB_RegWEn <= '1';
            -- AUIPC Instruction
            when "00101" => 
                WB_RegWEn <= '1';
            when others =>
                WB_RegWEn <= '0';
        end case;
        end if;
    end process;
end Behavioral;
