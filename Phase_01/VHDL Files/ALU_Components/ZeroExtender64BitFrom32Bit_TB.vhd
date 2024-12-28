library ieee;
use ieee.std_logic_1164.all;

entity ZeroExtender64BitFrom32Bit_TB is
end entity ZeroExtender64BitFrom32Bit_TB;

architecture ArchitectureOFZeroExtender64BitFrom32Bit_TB of ZeroExtender64BitFrom32Bit_TB is
    component ZeroExtender64BitFrom32Bit is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(63 downto 0)
        );
    end component;

    signal input_1_tb : std_logic_vector(31 downto 0) := (others => '0');
    signal output_1_tb : std_logic_vector(63 downto 0);

    begin

        ZeroExtender64BitFrom32Bit_TB : ZeroExtender64BitFrom32Bit
            port map(
                input_1 => input_1_tb,
                output_1 => output_1_tb
            );
        
        process
            begin
                wait for 10 ps;
                input_1_tb <= "00000000000000000000000000000000";

                wait for 10 ps;
                input_1_tb <= "00000000000000000000000000000001";

                wait for 10 ps;
                input_1_tb <= "10000000000000000000000000000000";

                wait for 10 ps;
                input_1_tb <= "11000000000000000000000000000000";

                wait for 10 ps;
                input_1_tb <= "11111111111111111111111111111111";

            end process;
end ArchitectureOFZeroExtender64BitFrom32Bit_TB;

