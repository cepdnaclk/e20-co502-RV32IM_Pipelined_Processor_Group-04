library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder_unit is
port(
    A, B : in std_logic_vector(31 downto 0);
    ADD_RESULT : out std_logic_vector(31 downto 0)
);
end adder_unit;

architecture adder_arch of adder_unit is
begin
    ADD_PROC: process(A, B)
    begin
        -- Convert std_logic_vector to signed, perform addition, and convert back
        ADD_RESULT <= std_logic_vector(signed(A) + signed(B));
    end process ADD_PROC;
end adder_arch;