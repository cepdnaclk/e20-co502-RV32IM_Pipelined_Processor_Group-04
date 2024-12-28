library ieee;
use ieee.std_logic_1164.all;

entity SLTU_TB is
end entity SLTU_TB;

architecture Logic_01 of SLTU_TB is
    component SetLessThanUnsigned
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    signal input_1_tb, input_2_tb , output_1_tb : std_logic_vector(31 downto 0) := (others => '0');

    begin

        SLTU_Impl : SetLessThanUnsigned
            port map(
                input_1 => input_1_tb,
                input_2 => input_2_tb,
                output_1 => output_1_tb
            );

        process
        begin
            wait for 10 ps;
            
            input_1_tb <= "00000000000000000000000000000001";
            input_2_tb <= "00000000000000000000000000000001";
            wait for 10 ps;

            input_1_tb <= "00000000000000000000000000000010";
            input_2_tb <= "00000000000000000000000000000001";
            wait for 10 ps;

            input_1_tb <= "00000000000000000000000000000010";
            input_2_tb <= "00000000000000000000000000000110";
            wait for 10 ps;

            input_1_tb <= "00000000000000000000000000000010";
            input_2_tb <= "00000000000000000000000000000011";
            wait for 10 ps;

            input_1_tb <= "10000000000000000000000000000000";
            input_2_tb <= "10000000000000000000000000000000";
            wait for 10 ps;

            input_1_tb <= "10000000000000000000000000000000";
            input_2_tb <= "10000000000000000000000000000001";
            wait for 10 ps;

            input_1_tb <= "10000000000000000000000000000001";
            input_2_tb <= "10000000000000000000000000000000";
            wait for 10 ps;

            input_1_tb <= "00000000000000000000000000000000";
            input_2_tb <= "10000000000000000000000000000000";
            wait for 10 ps;

            input_1_tb <= "00000000000000000000000000000001";
            input_2_tb <= "11111111111111111111111111111111";

            
        end process;

end architecture Logic_01;
