library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Comparator_tb is
end entity Comparator_tb;

architecture Comparator_tb_architecture of Comparator_tb is
    -- Component declaration
    component Comparator is
        port(
            input_1 : in std_logic_vector(31 downto 0);
            input_2 : in std_logic_vector(31 downto 0);
            output_signed : out std_logic_vector(1 downto 0);
            output_unsigned : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Signals for inputs and outputs
    signal input_1 : std_logic_vector(31 downto 0);
    signal input_2 : std_logic_vector(31 downto 0);
    signal output_signed : std_logic_vector(1 downto 0);
    signal output_unsigned : std_logic_vector(1 downto 0);

begin
    -- Instantiate the Comparator
    Comparator_Impl: Comparator
        port map(
            input_1 => input_1,
            input_2 => input_2,
            output_signed => output_signed,
            output_unsigned => output_unsigned
        );

    -- Stimulus process
    process
    begin
        -- Test Case 1: Signed and Unsigned Equality
        input_1 <= "00000000000000000000000000001010"; -- Signed: 10, Unsigned: 10
        input_2 <= "00000000000000000000000000001010"; -- Signed: 10, Unsigned: 10
        wait for 10 ps;

        -- Test Case 2: Signed input_1 > input_2, Unsigned input_1 > input_2
        input_1 <= "00000000000000000000000000001111"; -- Signed: 15, Unsigned: 15
        input_2 <= "00000000000000000000000000001010"; -- Signed: 10, Unsigned: 10
        wait for 10 ps;

        -- Test Case 3: Signed input_1 < input_2, Unsigned input_1 > input_2
        input_1 <= "11111111111111111111111111111011"; -- Signed: -5
        input_2 <= "00000000000000000000000000001010"; -- Signed: 10
        wait for 10 ps;

        -- Test Case 4: Signed input_1 > input_2, Unsigned input_1 < input_2
        input_1 <= "11111111111111111111111111110110"; -- Signed: -10
        input_2 <= "11111111111111111111111111110101"; -- Signed: -15
        wait for 10 ps;

        -- Test Case 5: Unsigned input_1 < input_2
        input_1 <= "00000000000000000000000000000101"; -- Unsigned: 5
        input_2 <= "00000000000000000000000000001010"; -- Unsigned: 20
        wait for 10 ps;

        -- Test Case 6: Boundary values
       -- input_1 <= std_logic_vector(to_signed(2147483647, 32)); -- Max signed 32-bit value
        --input_2 <= std_logic_vector(to_signed(-2147483648, 32)); -- Min signed 32-bit value
        --wait for 10 ps;

        -- Stop simulation
        wait;
    end process;
end architecture Comparator_tb_architecture;
