library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity wbmux is
    port(
        IN0, IN1, IN2: in std_logic_vector(31 downto 0); -- 3 separate 32-bit inputs
        SEL     : in std_logic_vector(1 downto 0);       -- 2-bit selection signal
        DATA_OUT : out std_logic_vector(31 downto 0)     -- 32-bit selected output
    );
end wbmux;

architecture mux_arch of wbmux is
begin
    process(IN0, IN1, IN2, SEL)
    begin
        case SEL is
            when "00" => DATA_OUT <= IN0; -- Select input 0
            when "01" => DATA_OUT <= IN1; -- Select input 1
            when "10" => DATA_OUT <= IN2; -- Select input 2
            when others => DATA_OUT <= (others => '0'); -- Default: Invalid SEL
        end case;
    end process;
end mux_arch;
