library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity and_unit is
port(
    A, B : in std_logic_vector(31 downto 0);
    AND_RESULT : out std_logic_vector(31 downto 0)
);
end and_unit;

architecture and_arch of and_unit is
begin
    AND_PROC: process(A, B)
    begin
        -- Convert std_logic_vector to signed, perform ORition, and convert back
        AND_RESULT <= std_logic_vector(A and B);
    end process AND_PROC;
end and_arch;