library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sll_unit is
port(
    A : in std_logic_vector(31 downto 0);         -- Value to shift
    B : in std_logic_vector(31 downto 0);         -- Shift amount
    SLL_RESULT : out std_logic_vector(31 downto 0) -- Shift result
);
end sll_unit;

architecture sll_arch of sll_unit is
begin
    SHIFT_PROC: process(A, B)
    variable shift_amount : integer;
    begin
        -- Convert B to integer (shift amount)
        shift_amount := to_integer(unsigned(B(4 downto 0))); -- Limit shift to 0-31 bits
        
        -- Perform the shift on A
        SLL_RESULT <= std_logic_vector(shift_left(unsigned(A), shift_amount));
    end process SHIFT_PROC;
end sll_arch;
