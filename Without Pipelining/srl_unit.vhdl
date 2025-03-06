library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SRL_unit is
port(
    A : in std_logic_vector(31 downto 0);         -- Value to shift
    B : in std_logic_vector(31 downto 0);         -- Shift amount
    SRL_RESULT : out std_logic_vector(31 downto 0) -- Shift result
);
end SRL_unit;

architecture SRL_arch of SRL_unit is
begin
    SHIFT_PROC: process(A, B)
    variable shift_amount : integer;
    begin
        -- Convert B to integer (shift amount)
        shift_amount := to_integer(unsigned(B(4 downto 0))); -- Limit shift to 0-31 bits
        
        -- Perform the shift on A
        SRL_RESULT <= std_logic_vector(shift_right(unsigned(A), shift_amount));
    end process SHIFT_PROC;
end SRL_arch;
