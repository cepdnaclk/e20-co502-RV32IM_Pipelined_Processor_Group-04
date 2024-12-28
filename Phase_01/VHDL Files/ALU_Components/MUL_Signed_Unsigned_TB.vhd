library ieee;
use ieee.std_logic_1164.all;

entity MUL_SIGNED_UNSIGNED_TB is
end entity MUL_SIGNED_UNSIGNED_TB;

architecture MUL_TB_architecture of MUL_SIGNED_UNSIGNED_TB is
    component MUL_Signed_Unsigned is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component MUL_Signed_Unsigned;


    signal input_1_tb, input_2_tb  : std_logic_vector(31 downto 0) := (others => '0');
    signal output_1_tb : std_logic_vector(31 downto 0) ;
    
    begin
        MUL_SIGNED_Impl : MUL_Signed_Unsigned
            port map(
                input_1 => input_1_tb,
                input_2 => input_2_tb,
                output_1 => output_1_tb
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

            wait for 10 ps;
            input_1_tb <= "11111111111111111111111111111111";
            input_2_tb <= "11111111111111111111111111111111";

            wait for 10 ps;
            input_1_tb <= "11111111111111111111111111111110";
            input_2_tb <= "11111111111111111111111111111111";

            wait for 10 ps;
            input_1_tb <= "11111111111111111111111111111110";
            input_2_tb <= "11111111111111111111111111111110";

            wait for 10 ps;
            input_1_tb <= "11111111111111111111111111111110";
            input_2_tb <= "00000000000000000000000000000001";

            wait for 10 ps;
            input_1_tb <= "11111111111111111111111111111110";
            input_2_tb <= "00000000000000000000000000000010";

        end process;
end architecture MUL_TB_architecture;
