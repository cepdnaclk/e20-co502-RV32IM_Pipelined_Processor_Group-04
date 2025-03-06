library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EX_Control is
    Port (
        reset     : in  std_logic;                      -- Reset signal
        EX_Inst   : in  std_logic_vector(31 downto 0);  -- Instruction from EX stage
        EX_ImmSel : out std_logic_vector(2 downto 0);   -- Immediate value generator signal
        EX_BrUn   : out std_logic;                      -- Branch unsigned control bit
        EX_BrEq   : in  std_logic;                      -- Branch equal control bit
        EX_BrL    : in  std_logic;                      -- Branch less than control bit
        EX_BSel   : out std_logic;                      -- B select
        EX_ASel   : out std_logic;                      -- A select
        EX_PCSel  : out std_logic;                      -- PC select
        EX_ALUSel : out std_logic_vector(3 downto 0)    -- ALU operation select
    );
end EX_Control;

architecture Behavioral of EX_Control is
begin
    process(reset, EX_Inst, EX_BrEq, EX_BrL)
    begin
        -- Reset condition: Set default values for all outputs
        if reset = '1' then
            EX_ImmSel <= (others => '0');
            EX_BrUn   <= '0';
            EX_BSel   <= '0';
            EX_ASel   <= '0';
            EX_PCSel   <= '0';
            EX_ALUSel <= (others => '0');
        else
            -- Default values for outputs
            EX_ImmSel <= (others => '0');
            EX_BrUn   <= '0';
            EX_BSel   <= '0';
            EX_ASel   <= '0';
            EX_PCSel   <= '0';
            EX_ALUSel <= (others => '0');

            -- Decode opcode (bits 6 downto 2 of the instruction)
            case EX_Inst(6 downto 2) is
                -- R and M -Type Instructions
                when "01100" => 
                    EX_BSel   <= '0';  -- Use register value for ALU input B
                    if EX_Inst(25) = '0' then 
                        -- R Type
                        case EX_Inst(14 downto 12) is
                            when "000" =>
                                if EX_Inst(30) = '0' then EX_ALUSel <= "0000"; -- ADD
                                else EX_ALUSel <= "0001"; -- SUB
                                end if;
                            when "001" => EX_ALUSel <= "0101"; -- SLL
                            when "010" => EX_ALUSel <= "1000"; -- SLT
                            when "011" => EX_ALUSel <= "1101"; -- SLTU
                            when "100" => EX_ALUSel <= "0100"; -- XOR
                            when "101" =>
                                if EX_Inst(30) = '0' then EX_ALUSel <= "0110"; -- SRL
                                else EX_ALUSel <= "0111"; -- SRA
                                end if;
                            when "110" => EX_ALUSel <= "0011"; -- OR
                            when "111" => EX_ALUSel <= "0010"; -- AND
                            when others => EX_ALUSel <= (others => '0'); -- Invalid
                        end case;
                    else 
                        -- M Type
                        case EX_INST(14 downto 12) is
                            when "000" => EX_ALUSel <= "1001"; -- MUL
                            when "001" => EX_ALUSel <= "1010"; -- MULH
                            when "011" => EX_ALUSel <= "1011"; -- MULHU
                            when "100" => EX_ALUSel <= "1101"; -- DIV
                            when "101" => EX_ALUSel <= "1110"; -- DIVU
                            when "110" => EX_ALUSel <= "1111"; -- REM
                            when others => EX_ALUSel <= (others => '0'); -- Invalid
                        end case;
                    end if;
                -- I-Type Instructions
                when "00100" => 
                    EX_BSel   <= '1';  -- Use immediate value for ALU input B
                    EX_ImmSel <= "000";  -- I-Type immediate

                    case EX_Inst(14 downto 12) is
                        when "000" => EX_ALUSel <= "0000"; -- ADDI
                        when "010" => EX_ALUSel <= "1000"; -- SLTI
                        when "011" => EX_ALUSel <= "1101"; -- SLTIU
                        when "100" => EX_ALUSel <= "0100"; -- XORI
                        when "110" => EX_ALUSel <= "0011"; -- ORI
                        when "111" => EX_ALUSel <= "0010"; -- ANDI
                        when "001" => EX_ALUSel <= "0101"; -- SLLI
                        when "101" => EX_ALUSel <= "0111"; -- SRAI
                        when others => EX_ALUSel <= "0000"; -- Invalid default to ADD
                    end case;

                -- Load Instructions
                when "00000" => 
                    EX_BSel   <= '1';  -- Use immediate value for ALU input B
                    EX_ImmSel <= "000";  -- I-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation

                -- Store Instructions
                when "01000" => 
                    EX_BSel   <= '1';  -- Use immediate value for ALU input B
                    EX_ImmSel <= "001";  -- S-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation

                -- Branch Instructions
                when "11000" => 
                    EX_BSel   <= '1';  -- Use immediate value for ALU input B
                    EX_ImmSel <= "010";  -- B-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation
                    EX_ASel   <= '1';  -- Use PC for ALU input A
                    if EX_Inst(13) = '0' then EX_BrUn <= '0'; -- Signed Comparison
                    else EX_BrUn <= '1'; -- Unsigned Comparison
                    end if;
                    case EX_Inst(14 downto 12) is
                        when "000" => EX_PCSel <= EX_BrEq; -- BEQ
                        when "001" => EX_PCSel <= not EX_BrEq; -- BNE
                        when "100" => EX_PCSel <= EX_BrL; -- BLT
                        when "101" => EX_PCSel <= not EX_BrL or EX_BrEq; -- BGE
                        when others => EX_PCSel <= '0'; -- Invalid
                    end case;

                -- JAL Instruction
                when "11011" => 
                    EX_BSel   <= '1';  -- Use immediate value for ALU input B
                    EX_ImmSel <= "011";  -- J-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation
                    EX_ASel   <= '1';  -- Use PC for ALU input A

                -- JALR Instruction
                when "11001" => 
                    EX_BSel   <= '1';  -- Use immediate value for ALU input B
                    EX_ImmSel <= "000";  -- I-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation
                    EX_ASel   <= '0';  -- Use register value for ALU input A

                -- LUI Instruction
                when "01101" => 
                    EX_BSel   <= '1';  -- Use immediate value for ALU input B
                    EX_ImmSel <= "100";  -- U-Type immediate
                    EX_ALUSel <= "1100";  -- Forward immediate

                -- AUIPC Instruction
                when "00101" => 
                    EX_BSel   <= '1';  -- Use immediate value for ALU input B
                    EX_ImmSel <= "100";  -- U-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation
                    EX_ASel   <= '1';  -- Use PC for ALU input A

                -- Default case for invalid opcodes
                when others =>
                    EX_ImmSel <= (others => '0');
                    EX_BrUn   <= '0';
                    EX_BSel   <= '0';
                    EX_ASel   <= '0';
                    EX_ALUSel <= (others => '0');
            end case;
        end if;
    end process;
end Behavioral;
