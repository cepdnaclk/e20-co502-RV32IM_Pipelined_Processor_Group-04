library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EX_Control is
    Port (
        reset     : in  std_logic;                      -- Reset signal
        EX_Inst   : in  std_logic_vector(31 downto 0);  -- Instruction from EX stage
        MEM_Inst  : in  std_logic_vector(31 downto 0);  -- Instruction from MEM stage
        WB_Inst   : in  std_logic_vector(31 downto 0);  -- Instruction from WB stage
        EX_ImmSel : out std_logic_vector(2 downto 0);   -- Immediate value generator signal
        EX_BrUn   : out std_logic;                      -- Branch unsigned control bit
        EX_BrEq   : in  std_logic;                      -- Branch equal control bit
        EX_BrL    : in  std_logic;                      -- Branch less than control bit
        EX_ASel   : out std_logic_vector(1 downto 0);   -- A select
        EX_BSel   : out std_logic_vector(1 downto 0);   -- B select
        EX_PCSel  : out std_logic;                      -- PC select
        EX_ALUSel : out std_logic_vector(3 downto 0)    -- ALU operation select
    );
end EX_Control;

architecture Behavioral of EX_Control is
    signal MEM_Rd  : std_logic_vector(4 downto 0);
    signal WB_Rd   : std_logic_vector(4 downto 0);
    signal EX_Rs1  : std_logic_vector(4 downto 0);
    signal EX_Rs2  : std_logic_vector(4 downto 0);
begin
    process(reset, EX_Inst, MEM_Inst, WB_Inst, EX_BrEq, EX_BrL, MEM_Rd, EX_Rs1, EX_Rs2)
        begin
        EX_ImmSel <= (others => '0');
        EX_BrUn   <= '0';
        EX_PCSel  <= '0';
        EX_ALUSel <= (others => '0');
        EX_ASel   <= "00";  -- Ensure it has a default value
        EX_BSel   <= "00";  -- Ensure it has a default value
        
        if reset = '1' then
            -- Reset condition: Set all outputs to known values
            EX_ImmSel <= (others => '0');
            EX_BrUn   <= '0';
            EX_BSel   <= "00";
            EX_ASel   <= "00";
            EX_PCSel  <= '0';
            EX_ALUSel <= (others => '0');
            EX_Rs1    <= (others => '0');
            EX_Rs2    <= (others => '0');
            MEM_Rd    <= (others => '0');
            WB_Rd     <= (others => '0');
        else
            -- Decode register fields
            MEM_Rd  <= MEM_Inst(11 downto 7);  -- Destination register in MEM stage
            WB_Rd   <= WB_Inst(11 downto 7);  -- Destination register in WB stage
            EX_Rs1  <= EX_Inst(19 downto 15); -- Source register 1 in EX stage
            EX_Rs2  <= EX_Inst(24 downto 20); -- Source register 2 in EX stage
        
            -- Decode opcode (bits 6 downto 2 of the instruction)
            case EX_Inst(6 downto 2) is
                -- R and M -Type Instructions
                when "01100" => 
                    EX_ASel <= "00";
                    EX_BSel <= "00";

                    if EX_Rs1 /= "00000" then
                        if (EX_Rs2 = WB_Rd) then
                            EX_BSel <= "11"; -- MEM FWD to B
                        end if;
                        if (EX_Rs1 = WB_Rd) then
                            EX_ASel <= "11"; -- MEM FWD to A
                        end if;
                        if (EX_Rs1 = MEM_Rd) then
                            EX_ASel <= "10"; -- ALU FWD to A
                        end if;
                        if (EX_Rs2 = MEM_Rd) then
                            EX_BSel <= "10"; -- ALU FWD to B
                        end if;
                    end if; 

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
                    EX_BSel   <= "01";  -- Use immediate value for ALU input B
                    EX_ImmSel <= "000";  -- I-Type immediate

                    if EX_Rs1 /= "00000" then
                        if (EX_Rs1 = WB_Rd) then
                            EX_ASel <= "11"; -- MEM FWD to A
                        end if;
                        if (EX_Rs1 = MEM_Rd) then
                            EX_ASel <= "10"; -- ALU FWD to A
                        end if;
                    end if; 

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
                    EX_BSel   <= "01";  -- Use immediate value for ALU input B
                    EX_ImmSel <= "000";  -- I-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation
        
                -- Store Instructions
                when "01000" => 
                    EX_BSel   <= "01";  -- Use immediate value for ALU input B
                    EX_ImmSel <= "001";  -- S-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation
        
                -- Branch Instructions
                when "11000" => 
                    EX_BSel   <= "01";  -- Use immediate value for ALU input B
                    EX_ImmSel <= "010";  -- B-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation
                    EX_ASel   <= "01";  -- Use PC for ALU input A
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
                    EX_BSel   <= "01";  -- Use immediate value for ALU input B
                    EX_ImmSel <= "011";  -- J-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation
                    EX_ASel   <= "01";  -- Use PC for ALU input A
                    EX_PCSel <= '1'; -- Use ALU Result for PC
        
                -- JALR Instruction
                when "11001" => 
                    EX_BSel   <= "01";  -- Use immediate value for ALU input B
                    EX_ImmSel <= "000";  -- I-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation
                    EX_ASel   <= "00";  -- Use register value for ALU input A
                    EX_PCSel <= '1'; -- Use ALU Result for PC
        
                -- LUI Instruction
                when "01101" => 
                    EX_BSel   <= "01";  -- Use immediate value for ALU input B
                    EX_ImmSel <= "100";  -- U-Type immediate
                    EX_ALUSel <= "1100";  -- Forward immediate
        
                -- AUIPC Instruction
                when "00101" => 
                    EX_BSel   <= "01";  -- Use immediate value for ALU input B
                    EX_ImmSel <= "100";  -- U-Type immediate
                    EX_ALUSel <= "0000";  -- ADD operation
                    EX_ASel   <= "01";  -- Use PC for ALU input A
        
                -- Default case for invalid opcodes
                when others =>
                    EX_ImmSel <= (others => '0');
                    EX_BrUn   <= '0';
                    EX_BSel   <= "00";
                    EX_ASel   <= "00";
                    EX_ALUSel <= (others => '0');
            end case;
        end if;
    end process;
        
end Behavioral;
