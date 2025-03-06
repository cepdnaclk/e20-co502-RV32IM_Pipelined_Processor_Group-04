library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity or_unit is
port(
    A, B : in std_logic_vector(31 downto 0);
    OR_RESULT : out std_logic_vector(31 downto 0)
);
end or_unit;

architecture or_arch of or_unit is
begin
    OR_PROC: process(A, B)
    begin
        -- Convert std_logic_vector to signed, perform ORition, and convert back
        OR_RESULT <= std_logic_vector(A or B);
    end process OR_PROC;
end or_arch;