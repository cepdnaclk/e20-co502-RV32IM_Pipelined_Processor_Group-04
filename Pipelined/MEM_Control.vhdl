library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MEM_Control is
    Port (
        reset     : in  std_logic;                       -- Reset signal
        MEM_Inst  : in  std_logic_vector(31 downto 0);   -- Instruction from MEM stage
        MEM_MemRW : out std_logic;                        -- MemRW Signal
        MEM_WBSel : out std_logic_vector(1 downto 0)      -- WB Select Signal
    );
end MEM_Control;

architecture Behavioral of MEM_Control is
begin
    process(reset, MEM_Inst)
    begin
        -- Reset condition
        if reset = '1' then
            MEM_MemRW   <= '0';
            MEM_WBSel    <= "00";

        else
            MEM_MemRW   <= '0';
            MEM_WBSel    <= "00";
            case MEM_Inst(6 downto 2) is
                when "01000" => 
                    MEM_MemRW <= '1'; -- Store Operation
                when others =>
                    MEM_MemRW <= '0'; -- Other Operations
            end case;
        -- Decode opcode
        case MEM_Inst(6 downto 2) is
            -- R-Type Instructions
            when "01100" => 
                MEM_WBSel <= "01";
            -- I-Type Instructions
            when "00100" => 
                MEM_WBSel <= "01";
            -- Load Instructions
            when "00000" => 
                case MEM_Inst(1 downto 0) is
                    when "11" =>
                        MEM_WBSel <= "00";
                    when others =>
                        MEM_WBSel <= "00";
                end case;
            -- JAL Instruction
            when "11000" => 
                MEM_WBSel <= "01";
            -- JAL Instruction
            when "11011" => 
                MEM_WBSel <= "10";
            -- JALR Instruction
            when "11001" => 
                MEM_WBSel <= "10";
            -- LUI Instruction
            when "01101" => 
                MEM_WBSel <= "01";
            -- AUIPC Instruction
            when "00101" => 
                MEM_WBSel <= "01";
            when others =>
                MEM_WBSel <= "00";
        end case;
        end if;
    end process;
end Behavioral;
