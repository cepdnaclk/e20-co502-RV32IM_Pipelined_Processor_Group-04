library ieee;
use ieee.std_logic_1164.all;

entity MUL_TB is
end entity MUL_TB;

architecture MUL_TB_architecture of MUL_TB is
    component multiplier_unsigned is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0);
            output_2 : OUT std_logic_vector(31 downto 0)
        );
    end component;;


    signal input_1_tb, input_2_tb  : std_logic_vector(31 downto 0) := (others => '0');
    signal output_1_tb , output_2_tb : std_logic_vector(31 downto 0) ;
    
    begin
        MUL_Impl : multiplier
            port map(
                input_1 => input_1_tb,
                input_2 => input_2_tb,
                output_1 => output_1_tb,
                output_2 => output_2_tb
            );

    process
        begin
            wait for 10 ps;
            input_1_tb <= "00000000000000000000000000000001";
            input_2_tb <= "00000000000000000000000000000000";

            wait for 10 ps;
            input_1_tb <= "00000000000000000000000000000001";
            input_2_tb <= "00000000000000000000000000000001";

            wait for 10 ps;
            input_1_tb <= "00000000000000000000000000000010";
            input_2_tb <= "00000000000000000000000000000001";

        end process;
end architecture MUL_TB_architecture;
