library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mul_unit is
    port(
        A, B : in std_logic_vector(31 downto 0);  -- Input operands
        MUL_RESULT : out std_logic_vector(31 downto 0); -- Lower 32-bits of signed result
        MULH_RESULT : out std_logic_vector(63 downto 32); -- upper 32-bits of signed result
        MULHU_RESULT : out std_logic_vector(63 downto 32) -- upper 32-bits of unsigned result
    );
end mul_unit;

architecture mul_arch of mul_unit is
begin
    MUL_PROC: process(A, B)
        variable s_result : signed(63 downto 0); -- 64-bit signed multiplication result
        variable u_result : unsigned(63 downto 0); -- 64-bit unsigned multiplication result
    begin
        -- Perform signed multiplication
        s_result := signed(A) * signed(B);
        u_result := unsigned(A) * unsigned(B);

        -- Assign the lower 32-bits of the result to MUL_RESULT
        MUL_RESULT <= std_logic_vector(s_result(31 downto 0));
        MULH_RESULT <= std_logic_vector(s_result(63 downto 32));
        MULHU_RESULT <= std_logic_vector(u_result(63 downto 32));
    end process MUL_PROC;
end mul_arch;
