library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux16x32 is
    port(
        IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9, IN10, IN11, IN12, IN13, IN14, IN15 : in std_logic_vector(31 downto 0); -- 16 separate 32-bit inputs
        SEL     : in std_logic_vector(3 downto 0);       -- 4-bit selection signal
        DATA_OUT : out std_logic_vector(31 downto 0)    -- 32-bit selected output
    );
end mux16x32;

architecture mux_arch of mux16x32 is
begin
    process(IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9, IN10, IN11, IN12, IN13, IN14, IN15, SEL)
    begin
        case SEL is
            when "0000" => DATA_OUT <= IN0; -- Select input 0
            when "0001" => DATA_OUT <= IN1; -- Select input 1
            when "0010" => DATA_OUT <= IN2; -- Select input 2
            when "0011" => DATA_OUT <= IN3; -- Select input 3
            when "0100" => DATA_OUT <= IN4; -- Select input 4
            when "0101" => DATA_OUT <= IN5; -- Select input 5
            when "0110" => DATA_OUT <= IN6; -- Select input 6
            when "0111" => DATA_OUT <= IN7; -- Select input 7
            when "1000" => DATA_OUT <= IN8; -- Select input 8
            when "1001" => DATA_OUT <= IN9; -- Select input 9
            when "1010" => DATA_OUT <= IN10; -- Select input 10
            when "1011" => DATA_OUT <= IN11; -- Select input 11
            when "1100" => DATA_OUT <= IN12; -- Select input 12
            when "1101" => DATA_OUT <= IN13; -- Select input 13
            when "1110" => DATA_OUT <= IN14; -- Select input 14
            when "1111" => DATA_OUT <= IN15; -- Select input 15
            when others => DATA_OUT <= (others => '0'); -- Default: Invalid SEL
        end case;
    end process;
end mux_arch;
