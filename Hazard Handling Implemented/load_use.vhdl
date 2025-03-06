library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity load_use is
    port (
        instr_ID : in std_logic_vector(31 downto 0); -- Instruction in ID stage
        instr_IF : in std_logic_vector(31 downto 0); -- Instruction in IF stage
        hazard   : out std_logic                     -- Load-Use Hazard signal
    );
end load_use;

architecture Behavioral of load_use is
    signal opcode_ID : std_logic_vector(6 downto 0);
    signal rd_ID     : std_logic_vector(4 downto 0);
    signal rs1_IF    : std_logic_vector(4 downto 0);
    signal rs2_IF    : std_logic_vector(4 downto 0);
begin
    process(instr_ID, instr_IF, rs1_IF, rs2_IF, rd_ID, opcode_ID)
    begin
        -- Extract fields from ID stage instruction (load instruction)
        opcode_ID <= instr_ID(6 downto 0);  -- Opcode (bits 6-0)
        rd_ID     <= instr_ID(11 downto 7); -- Destination register (rd)

        -- Extract source registers from IF stage instruction
        rs1_IF <= instr_IF(19 downto 15);  -- Source register 1 (rs1)
        rs2_IF <= instr_IF(24 downto 20);  -- Source register 2 (rs2)

        -- Default: No hazard
        hazard <= '0';

        -- Detect Load-Use Hazard:
        -- If ID stage has a Load instruction and IF stage depends on its result
        if (opcode_ID = "0000011") and  -- Load instruction in ID stage
           ((rd_ID = rs1_IF and rd_ID /= "00000") or (rd_ID = rs2_IF and rd_ID /= "00000")) then
           hazard <= '1';  -- Assert hazard signal
        end if;
    end process;
end Behavioral;
