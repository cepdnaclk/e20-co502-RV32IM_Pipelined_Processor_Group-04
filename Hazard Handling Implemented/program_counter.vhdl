library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    port (
        clk       : in  std_logic;                -- Clock signal
        reset     : in  std_logic;                -- Reset signal
        pc_in     : in  std_logic_vector(31 downto 0); -- Input to update the PC (from adder)
        pc_out    : out std_logic_vector(31 downto 0) -- Current PC value (to instruction memory)
    );
end PC;

architecture Behavioral of PC is
    -- Signal to hold the current PC value
    signal pc_reg : std_logic_vector(31 downto 0) := (others => '0');
begin
    -- Process to update the PC value
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset the PC to zero
            pc_reg <= (others => '0');
        elsif rising_edge(clk) then
            -- Update the PC with the input value
            pc_reg <= pc_in;
        end if;
    end process;
    -- Output the current PC value
    pc_out <= pc_reg;
end Behavioral;
