library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_unit is
    port(
        INST   : in std_logic_vector(31 downto 0); -- Instruction [31:0]
        RegWEn : out std_logic;                    -- Register File Write Enable
        ALUSel : out std_logic_vector(3 downto 0); -- ALU operation selector
        BSel   : out std_logic;                    -- Immediate operation selector
        WBSel  : out std_logic_vector(1 downto 0); -- Writeback Selector
        MemRW  : out std_logic;                    -- Memory Read/Write enable
        ImmSel : out std_logic_vector(2 downto 0); -- Immediate type selector
        PCSel  : out std_logic;                    -- Program Counter Select
        BrUn   : out std_logic;                    -- Branch Unsigned control bit
        BrEq   : in std_logic;                     -- Branch Equal Result
        BrLT   : in std_logic;                     -- Branch Less Than Result
        ASel   : out std_logic                     -- ALU Input A select
    );
end control_unit;

architecture control_unit_arch of control_unit is
begin
    CONTROL_LOGIC: process(INST, BrEq, BrLT) is
    begin
        -- Default values for outputs
        RegWEn <= '0'; 
        ALUSel <= (others => '0');
        BSel <= '0';
        WBSel <= "00";
        MemRW <= '0';
        ImmSel <= (others => '0');
        PCSel <= '0';
        BrUn <= '0';
        ASel <= '0';

        -- Decode opcode
        case INST(6 downto 2) is
            -- R-Type Instructions
            when "01100" => 
                RegWEn <= '1';
                BSel <= '0';
                WBSel <= "01";
                case INST(14 downto 12) is
                    when "000" =>
                        if INST(30) = '0' then ALUSel <= "0000"; -- ADD
                        else ALUSel <= "0001"; -- SUB
                        end if;
                    when "001" => ALUSel <= "0101"; -- SLL
                    when "010" => ALUSel <= "1000"; -- SLT
                    when "011" => ALUSel <= "1101"; -- SLTU
                    when "100" => ALUSel <= "0100"; -- XOR
                    when "101" =>
                        if INST(30) = '0' then ALUSel <= "0110"; -- SRL
                        else ALUSel <= "0111"; -- SRA
                        end if;
                    when "110" => ALUSel <= "0011"; -- OR
                    when "111" => ALUSel <= "0010"; -- AND
                    when others => ALUSel <= (others => '0'); -- Invalid
                end case;

            -- I-Type Instructions
            when "00100" => 
                RegWEn <= '1';
                BSel <= '1';
                WBSel <= "01";
                ImmSel <= "000"; -- I-Type immediate
                case INST(14 downto 12) is
                    when "000" => ALUSel <= "0000"; -- ADDI
                    when "010" => ALUSel <= "1000"; -- SLTI
                    when "011" => ALUSel <= "1101"; -- SLTIU
                    when "100" => ALUSel <= "0100"; -- XORI
                    when "110" => ALUSel <= "0011"; -- ORI
                    when "111" => ALUSel <= "0010"; -- ANDI
                    when "001" => ALUSel <= "0101"; -- SLLI
                    when "101" => ALUSel <= "0111"; -- SRAI
                    when others => ALUSel <= (others => '0'); -- Invalid
                end case;

            -- Load Instructions
            when "00000" => 
                RegWEn <= '1';
                BSel <= '1';
                WBSel <= "00";
                MemRW <= '0';
                ImmSel <= "000"; -- I-Type immediate
                ALUSel <= "0000"; -- ADD

            -- Store Instructions
            when "01000" => 
                RegWEn <= '0';
                BSel <= '1';
                MemRW <= '1';
                ImmSel <= "001"; -- S-Type immediate
                ALUSel <= "0000"; -- ADD

            -- Branch Instructions
            when "11000" => 
                RegWEn <= '0';
                BSel <= '1';
                ImmSel <= "010"; -- B-Type immediate
                ALUSel <= "0000"; -- ADD
                ASel <= '1';
                if INST(13) = '0' then BrUn <= '0'; -- Signed Comparison
                else BrUn <= '1'; -- Unsigned Comparison
                end if;
                case INST(14 downto 12) is
                    when "000" => PCSel <= BrEq; -- BEQ
                    when "001" => PCSel <= not BrEq; -- BNE
                    when "100" => PCSel <= BrLT; -- BLT
                    when "101" => PCSel <= not BrLT or BrEq; -- BGE
                    when others => PCSel <= '0'; -- Invalid
                end case;

            -- JAL Instruction
            when "11011" => 
                RegWEn <= '1';
                BSel <= '1';
                WBSel <= "10";
                ImmSel <= "011"; -- J-Type immediate
                PCSel <= '1';
                ASel <= '1';

            -- JALR Instruction
            when "11001" => 
                RegWEn <= '1';
                BSel <= '1';
                WBSel <= "10";
                ImmSel <= "000"; -- I-Type immediate
                PCSel <= '1';
                ASel <= '0';

            -- LUI Instruction
            when "01101" => 
                RegWEn <= '1';
                BSel <= '1';
                WBSel <= "01";
                ImmSel <= "100"; -- U-Type immediate
                ALUSel <= "1100"; -- Forward immediate

            -- AUIPC Instruction
            when "00101" => 
                RegWEn <= '1';
                BSel <= '1';
                WBSel <= "01";
                ImmSel <= "100"; -- U-Type immediate
                ALUSel <= "0000"; -- ADD
                ASel <= '1';

            when others =>
                -- Invalid Opcode
                RegWEn <= '0';
                ALUSel <= (others => '0');
        end case;
    end process;
end control_unit_arch;
