library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux2x32 is
    port(
        IN0, IN1: in std_logic_vector(31 downto 0);     -- 16 separate 32-bit inputs
        SEL     : in std_logic;                         -- 4-bit selection signal
        DATA_OUT : out std_logic_vector(31 downto 0)    -- 32-bit selected output
    );
end mux2x32;

architecture mux_arch of mux2x32 is
begin
    process(IN0, IN1, SEL)
    begin
        case SEL is
            when '0' => DATA_OUT <= IN0; -- Select input 0
            when '1' => DATA_OUT <= IN1; -- Select input 1
            when others => DATA_OUT <= (others => '0'); -- Default: Invalid SEL
        end case;
    end process;
end mux_arch;
