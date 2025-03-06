library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ID_EX_Register is
    Port (
        clk          : in  std_logic;                      -- Clock signal
        reset        : in  std_logic;                      -- Reset signal
        ID_PC        : in  std_logic_vector(31 downto 0);  -- PC from ID stage
        EX_PC        : out std_logic_vector(31 downto 0);  -- PC to EX stage
        ID_Reg1      : in  std_logic_vector(31 downto 0);  -- Register 1 value
        EX_Reg1      : out std_logic_vector(31 downto 0);  -- Register 1 to EX stage
        ID_Reg2      : in  std_logic_vector(31 downto 0);  -- Register 2 value   
        EX_Reg2      : out std_logic_vector(31 downto 0);  -- Register 2 to EX stage
        ID_Instr     : in  std_logic_vector(31 downto 0);  -- Instruction from ID stage
        EX_Instr     : out  std_logic_vector(31 downto 0)  -- Instruction from EX stage
    );
end ID_EX_Register;

architecture Behavioral of ID_EX_Register is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            EX_PC      <= (others => '0');  -- Reset PC
            EX_Reg1    <= (others => '0');  -- Reset Register 1
            EX_Reg2    <= (others => '0');  -- Reset Register 2
            EX_Instr   <= (others => '0');  -- Reset instruction
        elsif rising_edge(clk) then
            EX_PC      <= ID_PC;            -- Pass PC to EX stage
            EX_Reg1    <= ID_Reg1;          -- Pass Register 1 to EX stage
            EX_Reg2    <= ID_Reg2;          -- Pass Register 2 to EX stage
            EX_Instr   <= ID_Instr;         -- Pass instruction to EX stage
        end if;
    end process;
end Behavioral;