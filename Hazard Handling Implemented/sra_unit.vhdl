library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity arithmetic_shift_unit is
    port(
        A               : in std_logic_vector(31 downto 0);
        B               : in std_logic_vector(31 downto 0);
        SRA_RESULT      : out std_logic_vector(31 downto 0)
    );
end arithmetic_shift_unit;

architecture shift_arch of arithmetic_shift_unit is
begin
    process(A, B)
        variable shift_amt : integer;
        variable signed_input : signed(31 downto 0);
        variable signed_result : signed(31 downto 0);
    begin
        signed_input := signed(A);

        shift_amt := to_integer(unsigned(B(4 downto 0)));

        if shift_amt = 0 then
            signed_result := signed_input;
        else
            signed_result := signed_input srl shift_amt;
            if signed_input(31) = '1' then
                signed_result := signed_result or (to_signed(-1, 32) sll (32 - shift_amt));
            end if;
        end if;

        SRA_RESULT   <= std_logic_vector(signed_result);
    end process;
end shift_arch;
