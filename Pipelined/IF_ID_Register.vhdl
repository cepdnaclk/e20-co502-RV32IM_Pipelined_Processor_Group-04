library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IF_ID_Register is
    Port (
        clk      : in  std_logic;                      -- Clock signal
        reset    : in  std_logic;                      -- Reset signal
        IF_PC    : in  std_logic_vector(31 downto 0);  -- PC from IF stage
        IF_Instr : in  std_logic_vector(31 downto 0);  -- Instruction from IF stage
        ID_PC    : out std_logic_vector(31 downto 0);  -- PC to ID stage
        ID_Instr : out std_logic_vector(31 downto 0)   -- Instruction to ID stage
    );
end IF_ID_Register;

architecture Behavioral of IF_ID_Register is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            ID_PC    <= (others => '0');  -- Reset PC
            ID_Instr <= (others => '0');  -- Reset instruction
        elsif rising_edge(clk) then
            ID_PC    <= IF_PC;            -- Pass PC to ID stage
            ID_Instr <= IF_Instr;         -- Pass instruction to ID stage
        end if;
    end process;
end Behavioral;