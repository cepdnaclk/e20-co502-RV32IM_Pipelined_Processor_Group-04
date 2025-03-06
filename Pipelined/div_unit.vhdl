library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity div_unit is
    port(
        A, B       : in  std_logic_vector(31 downto 0);  -- Input operands
        DIV_RESULT : out std_logic_vector(31 downto 0);  -- Signed division result
        DIVU_RESULT: out std_logic_vector(31 downto 0);  -- Unsigned division result
        REM_RESULT : out std_logic_vector(31 downto 0)   -- Signed remainder
    );
end div_unit;

architecture div_arch of div_unit is
begin
    DIV_PROC: process(A, B)
        variable s_div_result  : signed(31 downto 0);
        variable u_div_result  : unsigned(31 downto 0);
        variable s_rem_result  : signed(31 downto 0);
        variable u_rem_result  : unsigned(31 downto 0);
    begin
        -- Handle division by zero (Return 0 if B = 0)
        if B = "00000000000000000000000000000000" then
            s_div_result := (others => '0');
            u_div_result := (others => '0');
            s_rem_result := (others => '0');
            u_rem_result := (others => '0');
        else
            -- Signed division and remainder
            s_div_result := signed(A) / signed(B);
            s_rem_result := signed(A) mod signed(B);

            -- Unsigned division and remainder
            u_div_result := unsigned(A) / unsigned(B);
            u_rem_result := unsigned(A) mod unsigned(B);
        end if;

        -- Assign outputs
        DIV_RESULT  <= std_logic_vector(s_div_result);
        DIVU_RESULT <= std_logic_vector(u_div_result);
        REM_RESULT  <= std_logic_vector(s_rem_result);
    end process DIV_PROC;
end div_arch;
