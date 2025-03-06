library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MEM_WB_Register is
    Port (
        clk          : in  std_logic;                      -- Clock signal
        reset        : in  std_logic;                      -- Reset signal
        MEM_RegWD    : in  std_logic_vector(31 downto 0);  -- Reg Write Data
        WB_RegWD     : out  std_logic_vector(31 downto 0);  -- Reg Write Data to WB
        MEM_Instr    : in  std_logic_vector(31 downto 0);  -- Instruction from MEM stage
        WB_Instr     : out  std_logic_vector(31 downto 0)  -- Instruction from WB stage
    );
end MEM_WB_Register;

architecture Behavioral of MEM_WB_Register is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            WB_RegWD    <= (others => '0');  -- Reset Register Write Data
            WB_Instr    <= (others => '0');  -- Reset Instruction
        elsif rising_edge(clk) then
            WB_RegWD    <= MEM_RegWD;      -- Pass Reg Write Data to WB Stage
            WB_Instr    <= MEM_Instr;      -- Pass Instruction to WB stage
        end if;
    end process;
end Behavioral;