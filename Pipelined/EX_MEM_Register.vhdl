library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EX_MEM_Register is
    Port (
        clk          : in  std_logic;                      -- Clock signal
        reset        : in  std_logic;                      -- Reset signal
        EX_PC        : in  std_logic_vector(31 downto 0);  -- PC from EX stage
        MEM_PC       : out std_logic_vector(31 downto 0); -- PC to MEM stage
        EX_ALUr      : in  std_logic_vector(31 downto 0);  -- ALU Result
        MEM_ALUr     : out std_logic_vector(31 downto 0); -- ALU Result to MEM
        EX_Reg2      : in  std_logic_vector(31 downto 0);  -- Register 2 value   
        MEM_Reg2     : out std_logic_vector(31 downto 0); -- Register 2 to MEM stage
        EX_Instr     : in  std_logic_vector(31 downto 0);  -- Instruction from EX stage
        MEM_Instr    : out  std_logic_vector(31 downto 0) -- Instruction from MEM stage
    );
end EX_MEM_Register;

architecture Behavioral of EX_MEM_Register is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            MEM_PC      <= (others => '0');  -- Reset PC
            MEM_ALUr    <= (others => '0');  -- Reset ALU Result
            MEM_Reg2    <= (others => '0');  -- Reset Register 2
            MEM_Instr   <= (others => '0');  -- Reset instruction
        elsif rising_edge(clk) then
            MEM_PC      <= EX_PC;            -- Pass PC to MEM stage
            MEM_ALUr    <= EX_ALUr;          -- Pass ALU Result to MEM stage
            MEM_Reg2    <= EX_Reg2;          -- Pass Register 2 to MEM stage
            MEM_Instr   <= EX_Instr;         -- Pass instruction to MEM stage
        end if;
    end process;
end Behavioral;