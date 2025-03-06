library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xor_unit is
port(
    A, B : in std_logic_vector(31 downto 0);
    XOR_RESULT : out std_logic_vector(31 downto 0)
);
end xor_unit;

architecture xor_arch of xor_unit is
begin
    XOR_PROC: process(A, B)
    begin
        -- Convert std_logic_vector to signed, perform XORition, and convert back
        XOR_RESULT <= std_logic_vector(A xor B);
    end process XOR_PROC;
end xor_arch;