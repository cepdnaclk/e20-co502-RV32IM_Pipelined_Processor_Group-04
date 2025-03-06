library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity subtract_slt_unit is
port(
    A, B : in std_logic_vector(31 downto 0);  -- Input operands
    SUB_RESULT : out std_logic_vector(31 downto 0); -- Subtraction result
    SLT_RESULT : out std_logic_vector(31 downto 0) -- Set Less Than result
);
end subtract_slt_unit;

architecture subtract_arch of subtract_slt_unit is
begin
    SUB_PROC: process(A, B)
        variable sub_result_signed : signed(31 downto 0);
    begin
        sub_result_signed := signed(A) - signed(B);
        SUB_RESULT <= std_logic_vector(sub_result_signed);
        -- Check if A < B based on the signed subtraction result
        if sub_result_signed < 0 then
            SLT_RESULT <= "00000000000000000000000000000001";
        else
            SLT_RESULT <= (others => '0');
        end if;
    end process SUB_PROC;
end subtract_arch;
