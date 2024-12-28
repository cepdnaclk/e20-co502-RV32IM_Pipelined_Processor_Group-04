library ieee;
use ieee.std_logic_1164.all;


entity SRL_TB is
end entity SRL_TB;

architecture SRL_TB_ARCHITECTURE of SRL_TB is
    component ShiftRightLogical is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    signal input_1_tb : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    signal input_2_tb : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    signal output_1_tb : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";

    
    begin
        SRL_Impl : ShiftRightLogical
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
            input_2_tb <= "00000000000000000000000000000010";

            wait for 10 ps;
            input_1_tb <= "00000000000000000000000000000010";
            input_2_tb <= "00000000000000000000000000000011";

            wait for 10 ps;
            input_1_tb <= "00000000000000000000000000000011";
            input_2_tb <= "00000000000000000000000000011111";

            wait for 10 ps;
            input_1_tb <= "00000000000000000000000000000001";
            input_2_tb <= "00000000000000000000000000100000";

        end process;
end architecture SRL_TB_ARCHITECTURE;